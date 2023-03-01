//
//  GamePlayFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// General Game Functions
extension ParkingWorkGame {
    
    func showCarOpenedSuccessMessage(of targetCar: TargetCar) {
        let carName = targetCar.carName
        
        openCarSuccessWindow?.position = CGPoint(x: (cameraNode?.frame.midX)!, y: (cameraNode?.frame.midY)!)
        openCarSuccessWindowGarageLabel?.text = "\(carName) появится в вашем гараже"
        openCarSuccessWindow?.alpha = 1
        
    }
    
    func hideCarOpenedSiccessMessage() {
        openCarSuccessWindow?.alpha = 0
    }
    
    /// Shows pop-up window, offering to try to open the lock when player comes сlose to it.
    func showOpenCarMessage(of targetCar: TargetCar) {
        
        // add one zero at the end if complexity 0.1 to display -> 0.10
        let complexity = "\(targetCar.lockComplexity)".count == 3 ? "\(targetCar.lockComplexity)0" : "\(targetCar.lockComplexity)"

        openCarWindow?.position = player!.position
        openCarWindowNameLabel?.text = "\(targetCar.carName)"
        openCarWindowLockTypeLabel?.text = "\(LOCK_TRANSLATIONS[targetCar.lockType] ?? "тип неизвестен")"
        openCarWindowComplexityNum?.text = "\(complexity)/1.00"
        
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
        if (abs(diffX) > 120 || abs(diffY) > 120) {
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
        
        window.position = player!.position
        
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
    
    
}

