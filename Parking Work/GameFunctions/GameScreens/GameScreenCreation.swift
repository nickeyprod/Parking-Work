//
//  GameScreenCreation.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

extension ParkingWorkGame {
    
    // creates menu screen to pause game and settings
    func createMenuScreen() {
        // background
        menuScreen = SKSpriteNode(texture: SKTexture(imageNamed: "MenuBackground"), size: CGSize(width: displayWidth!, height: displayHeight!))
        

        cameraNode?.addChild(menuScreen!)
        menuScreen?.position = CGPoint(x: 0, y: 0)
        menuScreen?.zPosition = 52
        menuScreen?.alpha = 0
        
        // resume game button
        let resumeGameBtn = SKShapeNode(rectOf: CGSize(width: 200, height: 40))
        let yPos = resumeGameBtn.frame.height
        resumeGameBtn.position = CGPoint(x: 0, y: yPos)
        resumeGameBtn.name = "ui-resumeGameBtn"
        resumeGameBtn.fillColor = Colors.MenuButtonsColor

        // resume game button label
        let resumeGameBtnLabel = SKLabelNode(text: "Продолжить")
        resumeGameBtnLabel.name = "ui-resumeGameBtnLabel"
        resumeGameBtnLabel.fontSize = 20
        resumeGameBtnLabel.fontName = "Baskerville-bold"
        resumeGameBtnLabel.fontColor = .white
        resumeGameBtnLabel.horizontalAlignmentMode = .center
        resumeGameBtnLabel.verticalAlignmentMode = .center

        resumeGameBtn.addChild(resumeGameBtnLabel)

        menuScreen?.addChild(resumeGameBtn)
        
        // level number label
        let levelNum = SKLabelNode(text: "Уровень \(levelNum)")
        levelNum.fontSize = 30
        levelNum.fontName = "Baskerville-bold"
        levelNum.position = CGPoint(x: 0, y: yPos * 2)
        menuScreen?.addChild(levelNum)
        
        // settings game button
        let settingsGameBtn = SKShapeNode(rectOf: CGSize(width: 200, height: 40))
        settingsGameBtn.position = CGPoint(x: 0, y: yPos - yPos - 2 )
        settingsGameBtn.name = "ui-gameSettingsBtn"
        settingsGameBtn.fillColor = Colors.MenuButtonsColor

        // settings game button label
        let settingsGameBtnLabel = SKLabelNode(text: "Настройки")
        settingsGameBtnLabel.name = "ui-gameSettingsBtnLabel"
        settingsGameBtnLabel.fontSize = 20
        settingsGameBtnLabel.fontName = "Baskerville-bold"
        settingsGameBtnLabel.fontColor = .white
        settingsGameBtnLabel.horizontalAlignmentMode = .center
        settingsGameBtnLabel.verticalAlignmentMode = .center

        settingsGameBtn.addChild(settingsGameBtnLabel)

        menuScreen?.addChild(settingsGameBtn)
        
        // game name label
        let gameName = SKLabelNode(text: "Parking Work")
        gameName.fontSize = 54
        gameName.fontName = "Chalkduster"
        gameName.fontColor = Colors.GameNameLabelColor
        gameName.position = CGPoint(x: 0, y: displayHeight! / 2 - 55)
        menuScreen?.addChild(gameName)
    }
    
    // Creates screen with task for the level description
    func createLevelTaskScreen() {

        // background
        taskScreen = SKSpriteNode(color: .black, size: CGSize(width: displayWidth!, height: displayHeight!))
        
        cameraNode?.addChild(taskScreen!)
        taskScreen?.position = CGPoint(x: 0, y: 0)
        taskScreen?.zPosition = 45
        taskScreen?.alpha = 0
        
        // close task screen button
        let closeTaskScreenBtn = SKShapeNode(circleOfRadius: 14)
        closeTaskScreenBtn.name = "ui-closeTaskBtn"
        closeTaskScreenBtn.fillColor = UIColor.gray
        closeTaskScreenBtn.alpha = 0.75
        closeTaskScreenBtn.position = CGPoint(x: -displayWidth! / 2 + 150, y: displayHeight! / 2 - 26)
        closeTaskScreenBtn.zPosition = 50
        
        // close task screen label
        let closeTaskScreenLabel = SKLabelNode(text: "X")
        closeTaskScreenLabel.name = "ui-closeTaskLabel"
        closeTaskScreenLabel.fontSize = 20
        closeTaskScreenLabel.fontName = "Baskerville-bold"
        closeTaskScreenLabel.fontColor = .white
        closeTaskScreenLabel.horizontalAlignmentMode = .center
        closeTaskScreenLabel.verticalAlignmentMode = .center
        
        closeTaskScreenBtn.addChild(closeTaskScreenLabel)
        
        taskScreen?.addChild(closeTaskScreenBtn)
        
        // level number label
        let levelNum = SKLabelNode(text: "Уровень \(levelNum)")
        levelNum.fontSize = 30
        levelNum.fontName = "Baskerville-bold"
        levelNum.position = CGPoint(x: 70, y: displayHeight! / 2 - 40)
        taskScreen?.addChild(levelNum)
        
        // level task message
        let spriteRect = SKSpriteNode()
//        spriteRect.size = CGSize(width: displayWidth! - 260, height: 100)
        spriteRect.color = UIColor(named: Colors.TaskMessageBackground.rawValue)!
        spriteRect.alpha = 0.9
        spriteRect.position = CGPoint(x: 70, y: displayHeight! / 2 - 130)
        
        let taskMessage = SKLabelNode(text: "Босс: \(UNICODE.leftChevrone)Марка машины мне не важна, на твое усмотрение. Главное,  доставь её к нам без полиции на хвосте, так чтобы мы убедились в твоих намерениях.\(UNICODE.rightChevrone)")
        taskMessage.fontSize = 24
        taskMessage.fontName = FONTS.Baskerville
        taskMessage.fontColor = UIColor.white
        taskMessage.preferredMaxLayoutWidth = displayWidth! - 240
        taskMessage.numberOfLines = 0
        taskMessage.horizontalAlignmentMode = .center
        taskMessage.verticalAlignmentMode = .center
        spriteRect.addChild(taskMessage)
        taskScreen?.addChild(spriteRect)
        
        spriteRect.size = CGSize(width: displayWidth! - 230, height: taskMessage.frame.height)
        
        let bossSiluette = SKSpriteNode(texture: SKTexture(imageNamed: "boss-siluette"))
        bossSiluette.setScale(0.48)
        bossSiluette.position = CGPoint(x: displayWidth! / 2 - 100, y: -displayHeight! / 2 + 20)
        taskScreen?.addChild(bossSiluette)
        
    }
}
