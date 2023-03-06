//
//  GamePlayFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// General Game Functions
extension ParkingWorkGame {
    
    func showCarOpenedSuccessMessage(of targetCar: Car) {
        let carName = targetCar.name
        
        openCarSuccessWindow?.position = CGPoint(x: (cameraNode?.frame.midX)!, y: (cameraNode?.frame.midY)!)
        openCarSuccessWindowGarageLabel?.text = "\(carName) появится в вашем гараже"
        openCarSuccessWindow?.alpha = 1
        
    }
    
    func hideCarOpenedSuccessMessage() {
        if openCarSuccessWindow?.alpha == 0 { return }
        openCarSuccessWindow?.alpha = 0
    }
    
    /// Shows pop-up window, offering to try to open the lock when player comes сlose to it.
    func showOpenCarMessage(of targetCar: Car, lockType: String) {
        
        if openCarWindow?.alpha != 0 { return }
        
        // add one zero at the end if complexity 0.1 to display -> 0.10
        let complexity = "\(targetCar.locks[lockType]!!)".count == 3 ? "\(targetCar.locks[lockType]!!)0" : "\(targetCar.locks[lockType]!!)"

        openCarWindow?.position = player!.position
        openCarWindowNameLabel?.text = "\(targetCar.name)"
        openCarWindowLockTypeLabel?.text = "\(LOCK_TRANSLATIONS[lockType] ?? "тип неизвестен")"
        openCarWindowComplexityNum?.text = "\(complexity)/1.00"
        
        
        // set complexity num color
        let comp = targetCar.locks[lockType]!!
   
        if comp >= 0.0 && comp <= 0.34 {
            openCarWindowComplexityNum?.fontColor = UIColor(named: Colors.OpenCarLockComplexityLightColor.rawValue)
        } else if (comp > 0.34 && comp <= 0.74 ) {
            openCarWindowComplexityNum?.fontColor = UIColor(named: Colors.OpenCarLockComplexityMiddleColor.rawValue)
        } else {
            openCarWindowComplexityNum?.fontColor = UIColor(named: Colors.OpenCarLockComplexityHardColor.rawValue)
        }
        
        openCarWindow?.alpha = 1
        
        // stop player movement
        // enter to initial player state
//        playerLocationDestination = player?.position
//        playerStateMachine.enter(IdleState.self)

    }
    
    /// Hides pop-up window, that offering to open car lock.
    func hideOpenCarMessage() {
        openCarWindow?.alpha = 0
    }
    
    func checkDistanceBetweenPlayerAndTargetLock() {
 
        let playerPosition = player?.position
        let targetLockPosition = currLockTarget?.parent?.position

        let diffX = abs(playerPosition!.x) - abs(targetLockPosition!.x)
        let diffY = abs(playerPosition!.y) - abs(targetLockPosition!.y)
        if (abs(diffX) > 150 || abs(diffY) > 150) {
            hideOpenCarMessage()
            currLockTarget = nil
        }
    }
    
    // this creates window text and buttons for open car message pop-up
    func createOpenCarMessage() {
        // window itself
        let window = SKShapeNode(rectOf: CGSize(width: 260, height: 170), cornerRadius: 10.0)
        
        // hide it initially
        window.alpha = 0
        window.zPosition = 11 // player=10 + 1
        
        window.fillColor = UIColor(named: Colors.OpenCarWindowColor.rawValue)!
        window.strokeColor = UIColor(named: Colors.OpenCarWindowColorStroke.rawValue)!
        window.name = "openCarMessageWindow"
        self.addChild(window)
        
        // car name label
        let carNameLabel = SKLabelNode(text: "Old Copper")
        carNameLabel.name = "carNameLabel"
        carNameLabel.fontSize = 30
        carNameLabel.fontName = "SignPainter-HouseScript"
        carNameLabel.fontColor = UIColor(named: Colors.OpenCarWindowCarNameColor.rawValue)
        carNameLabel.position = CGPoint(x: 0, y: 54)
        
        window.addChild(carNameLabel)
        
        // - message label set to 'Попробовать вскрыть?' initially
        let messageLabel = SKLabelNode(text: "Попробовать вскрыть?")
        messageLabel.name = "carMessage"
        messageLabel.position = CGPoint(x: 0, y: 26)
        messageLabel.fontName = "Copperplate"
        messageLabel.fontSize = 21
        messageLabel.fontColor = UIColor(named: Colors.OpenCarWindowCarMsgColor.rawValue)
        
        window.addChild(messageLabel)
        
        // - lock type label
        let lockTypeLabel = SKLabelNode(text: "")
        lockTypeLabel.name = "lockTypeLabel"
        lockTypeLabel.text = "Пассажирский замок"
        lockTypeLabel.fontName = "Hoefler Text"
        lockTypeLabel.fontSize = 18
        lockTypeLabel.fontColor = UIColor(named: Colors.OpenCarWindowLockTypeColor.rawValue)
        lockTypeLabel.position = CGPoint(x: 0, y: 1)
        
        window.addChild(lockTypeLabel)
        
        // complexity level label
        let complexityLabel = SKLabelNode(text: "Cложность")
        complexityLabel.name = "complexityLabel"
        complexityLabel.fontName = "Hoefler Text"
        complexityLabel.fontSize = 18
        complexityLabel.fontColor = UIColor(named: Colors.OpenCarWindowComplexityColor.rawValue)
        complexityLabel.position = CGPoint(x: -30, y: -24)
        
        window.addChild(complexityLabel)
        
        // complexity level number
        let complexityNumLabel = SKLabelNode(text: "0.08/1.00")
        complexityNumLabel.name = "complexityNumLevel"
        complexityNumLabel.fontName = "Hoefler Text"
        complexityNumLabel.fontSize = 18
        complexityNumLabel.fontColor = UIColor(named: Colors.OpenCarLockComplexityLightColor.rawValue)
        complexityNumLabel.position = CGPoint(x: 90, y: 0)
        
        complexityLabel.addChild(complexityNumLabel)
        
        //  open car button
        let yesBtn = SKShapeNode(rect: CGRect(x: -30, y: -70, width: 60, height: 30), cornerRadius: 6.0)
        yesBtn.fillColor = UIColor(named: Colors.OpenCarYesBtnColor.rawValue)!
        yesBtn.strokeColor = UIColor(named: Colors.OpenCarYesBtnColor.rawValue)!
        yesBtn.name = "yesOpenLockBtn"
        window.addChild(yesBtn)
        
        let yesBtnLabel = SKLabelNode(text: "Да")
        yesBtnLabel.name = "yesBtnLabel"
        yesBtnLabel.fontName = "Copperplate"
        yesBtnLabel.fontSize = 20
        yesBtnLabel.position = CGPoint(x: 0, y: -60)
        
        yesBtn.addChild(yesBtnLabel)
    }
    
    // this creates window text and buttons for open car success message pop-up
    func createOpenCarSuccessMessage() {
        // window itself
        let window = SKShapeNode(rectOf: CGSize(width: 500, height: 300), cornerRadius: 10.0)
        window.alpha = 0
        window.zPosition = 12 // player=10, suggestpopUp=11 + 1
        
        window.position = player!.position
        
        window.fillColor = UIColor(named: Colors.OpenCarSuccessWindowColor.rawValue)!
        window.strokeColor = UIColor(named: Colors.OpenCarSuccessWindowColor.rawValue)!
        window.name = "openCarSuccessWindow"
        
        self.addChild(window)
        
        // success label
        let successLabel = SKLabelNode(text: "Вскрытие успешно!")
        successLabel.name = "successLabel"
        successLabel.fontSize = 32
        successLabel.fontName = "American Typewriter Semibold"
        successLabel.fontColor = UIColor(named: Colors.OpenCarSuccessWindowSuccessLabelColor.rawValue)
        successLabel.position = CGPoint(x: 0, y: 80)
        window.addChild(successLabel)
        
        // car will go to garage label
        let toGarageLabel = SKLabelNode(text: "Old Copper появится в вашем гараже.")
        toGarageLabel.fontName = "American Typewriter Semibold"
        toGarageLabel.fontSize = 24
        toGarageLabel.fontColor = UIColor(named: Colors.OpenCarSuccessWindowGarageLabelColor.rawValue)
        toGarageLabel.position = CGPoint(x: 0, y: 0)
        toGarageLabel.name = "garageLabel"
        
        window.addChild(toGarageLabel)
        
        // good button window
        let goodBtn = SKShapeNode(rect: CGRect(x: -75, y: -100, width: 150, height: 40), cornerRadius: 6)
        goodBtn.name = "goodButton"
        goodBtn.fillColor = .gray
        goodBtn.strokeColor = .gray
        
        window.addChild(goodBtn)
        
        // good button label
        let goodBtnLabel = SKLabelNode(text: "Хорошо")
        goodBtnLabel.position = CGPoint(x: 0, y: -88)
        goodBtnLabel.fontColor = .black
        goodBtnLabel.alpha = 0.75
        
        goodBtnLabel.fontName = "American Typewriter Bold"
        goodBtnLabel.fontSize = 24
        goodBtnLabel.name = "goodLabel"
        
        goodBtn.addChild(goodBtnLabel)
    }
    
    func blinkLightSignals(of car: Car) {
        
        let lightSignals = car.node?.childNode(withName: "light_signals")
        
        let signalingCar = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(blinkLights), userInfo: lightSignals, repeats: true)
        
        // stop signal after 15 seconds
        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
            signalingCar.invalidate()
            self.removeAction(forKey: (car.node?.name)! + "_light_signal")
            car.signaling = false
        }
       
    }
    
    @objc func blinkLights(sender: Timer) {
        let lightSignals = sender.userInfo as? SKNode
        if lightSignals?.alpha == 0  {
            lightSignals?.alpha = 1
        } else {
            lightSignals?.alpha = 0
        }
        
    }
    
}

