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
        
    }
    
    func switchDriveButtonToRunButton() {
        self.runButton?.fillColor = UIColor.brown
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
    
    
}
