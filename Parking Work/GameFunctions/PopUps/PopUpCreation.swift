//
//  PopUpCreation.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

// Pop Up Creation Game Functions
extension ParkingWorkGame {
    
    // Creating action message pop-up
    func createActionMessage() {

        // window itself
        let windowRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 260, height: 30))
        let windowPath = CGPath(roundedRect: windowRect, cornerWidth: 6.0, cornerHeight: 6.0, transform: .none)
        let window = SKShapeNode(path: windowPath, centered: true)
        
        // hide it initially
        window.alpha = 0
        window.zPosition = 15
        
        // default to open car
        window.fillColor = UIColor(named: COLORS.OpenCarWindowColor.rawValue)!
        window.strokeColor = UIColor(named: COLORS.OpenCarWindowColorStroke.rawValue)!
        window.name = "ui-actionWindow"
        
        window.position = CGPoint(x: 20, y: -((displayHeight! / 2) - 28))
        self.cameraNode!.addChild(window)
        
        // - message label set to 'Попробовать вскрыть?' initially
        let messageLabel = SKLabelNode(text: "Попробовать вскрыть?")
        messageLabel.name = "ui-actionMessage"
        messageLabel.position = CGPoint(x: -30, y: 0)
        messageLabel.verticalAlignmentMode = .center
        messageLabel.fontName = "Copperplate"
        messageLabel.fontSize = 16
        messageLabel.fontColor = UIColor(named: COLORS.ActionWindowMsgColor.rawValue)
        
        window.addChild(messageLabel)
        
        // yes action button
        let rect = CGRect(x: 0, y: 0, width: 56, height: (window.frame.height) - 10)
        let path = CGPath(roundedRect: rect, cornerWidth: 6.0, cornerHeight: 6.0, transform: .none)
        let yesBtn = SKShapeNode(path: path, centered: true)
        yesBtn.position = CGPoint(x: (window.frame.width / 2) - (yesBtn.frame.width / 2) - 5, y: 0)
        yesBtn.fillColor = UIColor(named: COLORS.ActionMsgYesBtnColor.rawValue)!
        yesBtn.strokeColor = UIColor(named: COLORS.ActionMsgYesBtnColor.rawValue)!
        yesBtn.userData = NSMutableDictionary()
        yesBtn.userData?.setValue(GameButtons.ActionYesButton, forKey: "btn-type")
        
        window.addChild(yesBtn)
        
        let yesBtnLabel = SKLabelNode(text: "Да")
        yesBtnLabel.fontName = "Copperplate"
        yesBtnLabel.fontSize = 20
        yesBtnLabel.verticalAlignmentMode = .center
        yesBtnLabel.horizontalAlignmentMode = .center
        yesBtnLabel.position = CGPoint(x: 0, y: 0)
        
        yesBtnLabel.userData = NSMutableDictionary()
        yesBtnLabel.userData?.setValue(GameButtons.ActionYesButton, forKey: "btn-type")
        yesBtn.addChild(yesBtnLabel)
        
        actionMessageWindow = window
        
      
    }
    
    // Open car was successful message pop-up
    func createOpenCarSuccessMessage() {
        // window itself
        let window = SKShapeNode(rectOf: CGSize(width: 500, height: 300), cornerRadius: 10.0)
        window.alpha = 0
        window.zPosition = 200 // player=10, suggestpopUp=11 + 1
        
        window.fillColor = UIColor(named: COLORS.OpenCarSuccessWindowColor.rawValue)!
        window.strokeColor = UIColor(named: COLORS.OpenCarSuccessWindowColor.rawValue)!
        window.name = "openCarSuccessWindow"
        
        self.cameraNode?.addChild(window)
        
        // success label
        let successLabel = SKLabelNode(text: "Вскрытие успешно!")
        successLabel.name = "successLabel"
        successLabel.fontSize = 32
        successLabel.fontName = "American Typewriter Semibold"
        successLabel.fontColor = UIColor(named: COLORS.OpenCarSuccessWindowSuccessLabelColor.rawValue)
        successLabel.position = CGPoint(x: 0, y: 80)
        window.addChild(successLabel)
        
        // car will go to garage label
        let toGarageLabel = SKLabelNode(text: "Old Copper появится в вашем гараже.")
        toGarageLabel.fontName = "American Typewriter Semibold"
        toGarageLabel.fontSize = 24
        toGarageLabel.fontColor = UIColor(named: COLORS.OpenCarSuccessWindowGarageLabelColor.rawValue)
        toGarageLabel.position = CGPoint(x: 0, y: 0)
        toGarageLabel.name = "garageLabel"
        
        window.addChild(toGarageLabel)
        
        // good button window
        let goodBtn = SKShapeNode(rect: CGRect(x: -75, y: -100, width: 150, height: 40), cornerRadius: 6)
        goodBtn.fillColor = .gray
        goodBtn.strokeColor = .gray
        
        goodBtn.userData = NSMutableDictionary()
        goodBtn.userData?.setValue(GameButtons.GoodButton, forKey: "btn-type")
        
        window.addChild(goodBtn)
        
        // good button label
        let goodBtnLabel = SKLabelNode(text: "Хорошо")
        goodBtnLabel.position = CGPoint(x: 0, y: -88)
        goodBtnLabel.fontColor = .black
        goodBtnLabel.alpha = 0.75
        
        goodBtnLabel.fontName = "American Typewriter Bold"
        goodBtnLabel.fontSize = 24
        goodBtnLabel.userData = NSMutableDictionary()
        goodBtnLabel.userData?.setValue(GameButtons.GoodButton, forKey: "btn-type")
        goodBtn.addChild(goodBtnLabel)
    }
    
    
    // Creates player's current target item window at top of the screen
    func createTargetWindow() {
        
        // square itself
        targetWindow = SKSpriteNode(color: SKColor.black, size: CGSize(width: 210, height: 66))
        targetWindow?.anchorPoint = CGPoint(x: 0.5, y: 1)
        targetWindow?.position = CGPoint(x: 0, y: displayHeight! / 2 - 2)
        
        // set z position
        targetWindow?.zPosition = 15
        
        self.cameraNode?.addChild(targetWindow!)
        
        // target's name label
        let nameLabel = SKLabelNode(text: "Some Target")
        nameLabel.name = "target-name"
        nameLabel.horizontalAlignmentMode = .center
        nameLabel.verticalAlignmentMode = .center
        nameLabel.fontSize = 20
        nameLabel.fontName = "\(FONTS.Baskerville)-bold"
        nameLabel.verticalAlignmentMode = .top
        nameLabel.position = CGPoint(x: 0, y: (targetWindow?.frame.height)! / 2 - 38)
        targetWindowNameLabelPos = CGPoint(x: 0, y: (targetWindow?.frame.height)! / 2 - 38)
        
        targetWindow?.addChild(nameLabel)
        
        // target's car lock complexity
        // - lock type label
        let lockTypeLabel = SKLabelNode(text: "")
        lockTypeLabel.name = "lockTypeLabel"
        lockTypeLabel.text = "Пассажирский замок"
        lockTypeLabel.fontName = "Hoefler Text"
        lockTypeLabel.fontSize = 18
        lockTypeLabel.fontColor = UIColor(named: COLORS.OpenCarWindowLockTypeColor.rawValue)
        lockTypeLabel.verticalAlignmentMode = .top
        lockTypeLabel.position = CGPoint(x: 0, y: (targetWindow?.frame.height)! / 2 - 56)
        targetWindowLockTypeLabelPos = CGPoint(x: 0, y: (targetWindow?.frame.height)! / 2 - 56)
        
        targetWindow?.addChild(lockTypeLabel)
        
        // complexity level label
        let complexityLabel = SKLabelNode(text: "Cложность:")
        complexityLabel.name = "complexity-label"
        complexityLabel.fontName = "Hoefler Text"
        complexityLabel.fontSize = 18
        complexityLabel.fontColor = UIColor(named: COLORS.OpenCarWindowComplexityColor.rawValue)
        complexityLabel.verticalAlignmentMode = .top
        complexityLabel.position = CGPoint(x: -10, y: ((targetWindow?.frame.height)! / 2) - 76)
        targetWindowComplexityLabelPos = CGPoint(x: -10, y: ((targetWindow?.frame.height)! / 2) - 76)
        targetWindow?.addChild(complexityLabel)
        
        // complexity level number
        let complexityNumLabel = SKLabelNode(text: "8.0")
        complexityNumLabel.name = "complexityNumLevel"
        complexityNumLabel.fontName = "Hoefler Text"
        complexityNumLabel.fontSize = 18
        complexityNumLabel.fontColor = UIColor(named: COLORS.OpenCarLockComplexityLightColor.rawValue)
        complexityNumLabel.verticalAlignmentMode = .top
        complexityNumLabel.position = CGPoint(x: 72, y: -3)
    
        complexityLabel.addChild(complexityNumLabel)
        
        // remember initial target square height
        targetWindowInitialHeight = targetWindow?.frame.height
        
        // hidden initially
        hideTargetWindow()
        
    }
    
    func createUpperPopUp() {
        
        
        
        let someLabel = SKLabelNode(text: "Данные игры успешно загружены")
        someLabel.name = "msg-text"
        someLabel.verticalAlignmentMode = .center
        someLabel.position = CGPoint(x: 12, y: 0)
        someLabel.fontName = FONTS.AmericanTypewriter
        someLabel.fontSize = 16
    
        // Pop Up itself
        let popUpRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: someLabel.frame.width + 25 + 10, height: 30))
        let popUpPath = CGPath(roundedRect: popUpRect, cornerWidth: 6.0, cornerHeight: 6.0, transform: .none)
        
        let popUpWindow = SKShapeNode(path: popUpPath, centered: true)
        
        popUpWindow.position = CGPoint(x: 0, y: (displayHeight! / 2))
        
        popUpWindow.fillColor = .black
        popUpWindow.alpha = 0.90
        
        popUpWindow.addChild(someLabel)
        
        // sync icon
        let syncIcon = SKSpriteNode(imageNamed: "sync-circle")
        syncIcon.name = "sync-circle"
        syncIcon.size = CGSize(width: 20, height: 20)
        syncIcon.position = CGPoint(x: -(popUpWindow.frame.width / 2) + 18, y: 2)
        syncIcon.run(.rotate(toAngle: 0.2, duration: 0.3))
        popUpWindow.addChild(syncIcon)
        
        
        visibleUpperPopUpPos =  CGPoint(x: 0, y: (displayHeight! / 2) - (popUpWindow.frame.height / 2) - 20)
        upperPopUpMessage = popUpWindow
        upperPopUpMessage?.setScale(0)
        
        addChild(popUpWindow)
        
    }
}
