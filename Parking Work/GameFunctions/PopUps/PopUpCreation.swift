//
//  PopUpCreation.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

// Pop Up Creation Game Functions
extension ParkingWorkGame {
    // Open car suggestion message pop-up
    func createOpenCarMessage() {

        // window itself
        let window = SKShapeNode(rectOf: CGSize(width: 260, height: 40), cornerRadius: 10.0)
        
        // hide it initially
        window.alpha = 0
        window.zPosition = 11
        
        window.fillColor = UIColor(named: COLORS.OpenCarWindowColor.rawValue)!
        window.strokeColor = UIColor(named: COLORS.OpenCarWindowColorStroke.rawValue)!
        window.name = "ui-openCarMessageWindow"
        
        window.position = CGPoint(x: 16, y: -((displayHeight! / 2) - 28))
        self.cameraNode!.addChild(window)
        
        // - message label set to 'Попробовать вскрыть?' initially
        let messageLabel = SKLabelNode(text: "Попробовать вскрыть?")
        messageLabel.name = "ui-carMessage"
        messageLabel.position = CGPoint(x: -30, y: 0)
        messageLabel.verticalAlignmentMode = .center
        messageLabel.fontName = "Copperplate"
        messageLabel.fontSize = 16
        messageLabel.fontColor = UIColor(named: COLORS.OpenCarWindowCarMsgColor.rawValue)
        
        window.addChild(messageLabel)
        
        //  open car button
        let yesBtn = SKShapeNode(rect: CGRect(x: (window.frame.width / 2) - 64, y: -15, width: 56, height: 28), cornerRadius: 6.0)
        yesBtn.fillColor = UIColor(named: COLORS.OpenCarYesBtnColor.rawValue)!
        yesBtn.strokeColor = UIColor(named: COLORS.OpenCarYesBtnColor.rawValue)!
        yesBtn.name = "ui-yesOpenLockBtn"
        window.addChild(yesBtn)
        
        let yesBtnLabel = SKLabelNode(text: "Да")
        yesBtnLabel.name = "ui-yesBtnLabel"
        yesBtnLabel.fontName = "Copperplate"
        yesBtnLabel.fontSize = 20
        yesBtnLabel.verticalAlignmentMode = .center
        yesBtnLabel.horizontalAlignmentMode = .center
        yesBtnLabel.position = CGPoint(x: ((window.frame.width / 2) - 66) + (yesBtn.frame.width / 2), y: 0)
        
        yesBtn.addChild(yesBtnLabel)
        
        openCarWindow = window
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
    
    
    // Creates player's current target car window at top of the screen
    func createSelectedTarget() {
        
        // square itself
//        targetSquare = SKShapeNode(rectOf: CGSize(width: 210, height: 66))
        targetSquare = SKSpriteNode(color: SKColor.black, size: CGSize(width: 210, height: 66))
        targetSquare?.anchorPoint = CGPoint(x: 0.5, y: 1)
        targetSquare?.position = CGPoint(x: 0, y: displayHeight! / 2 - 2)
        
        // set z position
        targetSquare?.zPosition = 11
        
        self.cameraNode?.addChild(targetSquare!)
        
        // target's car name label
        let carLabel = SKLabelNode(text: "Some Car")
        carLabel.name = "car-name"
        carLabel.horizontalAlignmentMode = .center
        carLabel.verticalAlignmentMode = .center
        carLabel.fontSize = 20
        carLabel.fontName = "\(FONTS.Baskerville)-bold"
        carLabel.verticalAlignmentMode = .top
        carLabel.position = CGPoint(x: 0, y: (targetSquare?.frame.height)! / 2 - 38)
        targetSquareCarNameLabelPos = CGPoint(x: 0, y: (targetSquare?.frame.height)! / 2 - 38)
        
        targetSquare?.addChild(carLabel)
        
        // target's car lock complexity
        // - lock type label
        let lockTypeLabel = SKLabelNode(text: "")
        lockTypeLabel.name = "lockTypeLabel"
        lockTypeLabel.text = "Пассажирский замок"
        lockTypeLabel.fontName = "Hoefler Text"
        lockTypeLabel.fontSize = 18
        lockTypeLabel.fontColor = UIColor(named: COLORS.OpenCarWindowLockTypeColor.rawValue)
        lockTypeLabel.verticalAlignmentMode = .top
        lockTypeLabel.position = CGPoint(x: 0, y: (targetSquare?.frame.height)! / 2 - 56)
        targetSquareLockTypeLabelPos = CGPoint(x: 0, y: (targetSquare?.frame.height)! / 2 - 56)
        
        targetSquare?.addChild(lockTypeLabel)
        
        // complexity level label
        let complexityLabel = SKLabelNode(text: "Cложность:")
        complexityLabel.name = "complexity-label"
        complexityLabel.fontName = "Hoefler Text"
        complexityLabel.fontSize = 18
        complexityLabel.fontColor = UIColor(named: COLORS.OpenCarWindowComplexityColor.rawValue)
        complexityLabel.verticalAlignmentMode = .top
        complexityLabel.position = CGPoint(x: -10, y: ((targetSquare?.frame.height)! / 2) - 76)
        targetSquareComplexityLabelPos = CGPoint(x: -10, y: ((targetSquare?.frame.height)! / 2) - 76)
        targetSquare?.addChild(complexityLabel)
        
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
        targetSquareInitialHeight = targetSquare?.frame.height
        
        // hidden initially
        hideTargetSquare()
        
    }
}
