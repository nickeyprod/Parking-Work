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
        let window = SKShapeNode(rectOf: CGSize(width: 260, height: 30), cornerRadius: 10.0)
        
        // hide it initially
        window.alpha = 0
        window.zPosition = 11
        
        // default to open car
        window.fillColor = UIColor(named: COLORS.OpenCarWindowColor.rawValue)!
        window.strokeColor = UIColor(named: COLORS.OpenCarWindowColorStroke.rawValue)!
        window.name = "ui-actionWindow"
        
        window.position = CGPoint(x: 16, y: -((displayHeight! / 2) - 28))
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
        let yesBtn = SKShapeNode(rect: CGRect(x: (window.frame.width / 2) - 64, y: -12, width: 56, height: (window.frame.height) - 10), cornerRadius: 6.0)
        yesBtn.fillColor = UIColor(named: COLORS.ActionMsgYesBtnColor.rawValue)!
        yesBtn.strokeColor = UIColor(named: COLORS.ActionMsgYesBtnColor.rawValue)!
        yesBtn.name = "ui-actionYesBtn"
        window.addChild(yesBtn)
        
        let yesBtnLabel = SKLabelNode(text: "Да")
        yesBtnLabel.name = "ui-actionYesBtnLabel"
        yesBtnLabel.fontName = "Copperplate"
        yesBtnLabel.fontSize = 20
        yesBtnLabel.verticalAlignmentMode = .center
        yesBtnLabel.horizontalAlignmentMode = .center
        yesBtnLabel.position = CGPoint(x: ((window.frame.width / 2) - 66) + (yesBtn.frame.width / 2), y: 0)
        
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
    
    
    // Creates player's current target item window at top of the screen
    func createTargetWindow() {
        
        // square itself
        targetWindow = SKSpriteNode(color: SKColor.black, size: CGSize(width: 210, height: 66))
        targetWindow?.anchorPoint = CGPoint(x: 0.5, y: 1)
        targetWindow?.position = CGPoint(x: 0, y: displayHeight! / 2 - 2)
        
        // set z position
        targetWindow?.zPosition = 11
        
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
}
