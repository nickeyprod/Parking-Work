//
//  UIControls.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

extension ParkingWorkGame {
    
    func switchToCarDrivingUI() {
        switchRunButtonToDriveButton()
        inventoryButton?.removeFromParent()
        
        // add break button
        let brakeBtn = SKShapeNode(circleOfRadius: 28)
        self.brakeButton = brakeBtn
        brakeBtn.name = "ui-brakeBtn"
        brakeBtn.fillColor = UIColor.lightGray
        brakeBtn.alpha = 0.75
        brakeBtn.zPosition = 10
        brakeBtn.position = CGPoint(x: (displayWidth! / 2) - 160, y: -(displayHeight! / 2) + 80)
        
        let brakePedal = SKSpriteNode(texture: SKTexture(imageNamed: "brake-pedal"))
        brakePedal.name = "ui-brakeBtnImg"
        brakePedal.size.width = 50
        brakePedal.size.height = 50
        self.cameraNode?.addChild(brakeBtn)
        self.brakeButton?.addChild(brakePedal)
        
        // add arrows for turning left and right
        let arrowLeft = SKSpriteNode(texture: SKTexture(imageNamed: "arrow-left"))
        arrowLeft.name = "ui-arrow-left"
        
        arrowLeft.size.width = 56
        arrowLeft.size.height = 56
        arrowLeft.position = CGPoint(x: -(displayWidth! / 2) + 46, y: -(displayHeight! / 2) + 190)
        arrowLeft.zPosition = 25
        self.leftButton = arrowLeft
        self.cameraNode?.addChild(arrowLeft)
        
        let arrowRight = SKSpriteNode(texture: SKTexture(imageNamed: "arrow-right"))
        arrowRight.name = "ui-arrow-right"
        arrowRight.size.width = 56
        arrowRight.size.height = 56
        arrowRight.position = CGPoint(x: -(displayWidth! / 2) + 106, y: -(displayHeight! / 2) + 190)
        arrowRight.zPosition = 25
        self.rightButton = arrowRight
        self.cameraNode?.addChild(arrowRight)
        
        // exit from car button
        let exitButton = SKSpriteNode(texture: SKTexture(imageNamed: "car-door"))
        exitButton.name = "ui-exit-car-btn"
        exitButton.size.width = 56
        exitButton.size.height = 56
        exitButton.position = CGPoint(x: (displayWidth! / 2) - 40, y: -(displayHeight! / 2) + 180)
        exitButton.zPosition = 25
        self.exitFromCarBtn = exitButton
        self.cameraNode?.addChild(exitButton)
        
    }
    
    func switchDriveButtonToRunButton() {
        self.runButton?.fillColor = UIColor.brown
        // remove pedal image
        self.runButton?.childNode(withName: "ui-driveBtnImg")?.removeFromParent()
        
        self.runButton?.name = "ui-runBtn"
        let shoe = SKSpriteNode(texture: SKTexture(imageNamed: "shoe"))
        shoe.name = "ui-runBtnImg"
        shoe.size.width = 50
        shoe.size.height = 50
        self.runButton?.addChild(shoe)
    }
    
    func switchRunButtonToDriveButton() {
        // change button color
        self.runButton?.fillColor = UIColor.lightGray
        
        // remove shoe image
        self.runButton?.childNode(withName: "ui-runBtnImg")?.removeFromParent()
        // change name to drive
        self.runButton?.name = "ui-driveBtn"
        
        // add pedal image
        let pedal = SKSpriteNode(texture: SKTexture(imageNamed: "drive-pedal"))
        pedal.name = "ui-driveBtnImg"
        pedal.size.width = 50
        pedal.size.height = 50
        
        self.runButton?.addChild(pedal)
    }
    
    func switchToUsualUI() {
        self.leftButton?.removeFromParent()
        self.rightButton?.removeFromParent()
        self.brakeButton?.removeFromParent()
        self.exitFromCarBtn?.removeFromParent()
        self.switchDriveButtonToRunButton()
        self.addInventoryButton()
        
    }
    
    func addInventoryButton() {
        if let inventoryBag = UIImage(named: "shoulder-bag") {
            let inventorySprite = SKSpriteNode(texture: SKTexture(image: inventoryBag))
            self.inventoryButton = inventorySprite
            inventorySprite.zPosition = 10
            inventorySprite.name = "ui-inventory-btn"
            self.cameraNode?.addChild(inventorySprite)
            inventorySprite.size = CGSize(width: 36, height: 36)
            inventorySprite.position = CGPoint(x: -displayWidth! / 2 + 40, y: 0)
        }
    }
    
    
}
