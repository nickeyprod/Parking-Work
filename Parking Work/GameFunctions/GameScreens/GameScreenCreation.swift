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
        resumeGameBtn.fillColor = COLORS.MenuButtonsColor

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
        settingsGameBtn.fillColor = COLORS.MenuButtonsColor

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
        gameName.fontColor = COLORS.GameNameLabelColor
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
        spriteRect.color = UIColor(named: COLORS.TaskMessageBackground.rawValue)!
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
    
    func createPlayerInventoryScreen() {
        inventoryScreen = SKSpriteNode(color: .darkGray, size: CGSize(width: displayWidth! / 2, height: displayHeight!))
        inventoryScreen?.zPosition = 20
        
        cameraNode?.addChild(inventoryScreen!)
        
        inventoryScreen?.anchorPoint = CGPoint(x: 0, y: 0.5)
        inventoryScreen?.position = CGPoint(x: 0, y: 0)
        inventoryScreen?.zPosition = 52
//        inventoryScreen?.alpha = 1
        
        // Inventory header
        let inventoryHeaderLabel = SKLabelNode(text: "Сумка")
        inventoryHeaderLabel.verticalAlignmentMode = .center
        inventoryHeaderLabel.horizontalAlignmentMode = .center
        inventoryHeaderLabel.position = CGPoint(x: (inventoryScreen?.frame.width)! / 2, y: (inventoryScreen?.frame.height)! / 2 - 25)
        inventoryHeaderLabel.fontSize = 25
        inventoryHeaderLabel.fontName = FONTS.Cochin
        inventoryHeaderLabel.fontColor = UIColor(named: COLORS.InventoryHeader.rawValue)
        inventoryScreen?.addChild(inventoryHeaderLabel)
        
        // Inventory Capacity
        let inventoryCapacityLabel = SKLabelNode(text: "Вместимость: \(player!.inventory.count)/\(player!.inventoryMaxCapacity)")
        inventoryCapacityLabel.name = "inventory-capacity"
        inventoryCapacityLabel.verticalAlignmentMode = .top
        inventoryCapacityLabel.horizontalAlignmentMode = .right
        inventoryCapacityLabel.position = CGPoint(x: (inventoryScreen?.frame.width)! - 60, y: (inventoryScreen?.frame.height)! / 2 - 40)
        inventoryCapacityLabel.fontSize = 20
        inventoryCapacityLabel.fontName = FONTS.Cochin
        inventoryCapacityLabel.fontColor = UIColor(named: COLORS.InventoryHeader.rawValue)
        inventoryScreen?.addChild(inventoryCapacityLabel)
        
        // Close Button
        let closeInventoryBtn = SKShapeNode(circleOfRadius: 14)
        closeInventoryBtn.name = "ui-closeInventoryBtn"
        closeInventoryBtn.fillColor = UIColor.gray
        closeInventoryBtn.alpha = 0.55
        closeInventoryBtn.position = CGPoint(x: (inventoryScreen?.frame.width)! - 30, y: (inventoryScreen?.frame.height)! / 2 - 25)
        closeInventoryBtn.zPosition = 50
        
        // close task screen label
        let closeInventoryLabel = SKLabelNode(text: "X")
        closeInventoryLabel.name = "ui-closeInventoryLabel"
        closeInventoryLabel.fontSize = 20
        closeInventoryLabel.fontName = "Baskerville-bold"
        closeInventoryLabel.fontColor = .white
        closeInventoryLabel.horizontalAlignmentMode = .center
        closeInventoryLabel.verticalAlignmentMode = .center
        
        closeInventoryBtn.addChild(closeInventoryLabel)
        
        inventoryScreen?.addChild(closeInventoryBtn)
        
        fillInventoryWithItemSquares {
            closeInventory()
        }
    }
    
    func fillInventoryWithItemSquares(done: () -> Void) {
        let topPadding: CGFloat = 50
        let squareDimension: CGFloat = 50

        // calculate number of squares fit in one row according to screen width
        let numOfSquaresPerRow = Int(floor(((inventoryScreen?.frame.width)! / squareDimension)))
        // calculate number of rows according to player's capacity
        let numOfRows = (player?.inventoryMaxCapacity)! / (numOfSquaresPerRow - 1)
        
        // calculate square's every X position to distribute them equally
        var everyXPos = (inventoryScreen?.frame.width)! / CGFloat(numOfSquaresPerRow)
        
        // remember initial X position for adding it every loop run
        let initialXPos = everyXPos
        
        // variables reset every loop run
        var itemSquare: SKSpriteNode?
        var itemPic: SKSpriteNode?
        var squarePosition: CGPoint?
        var yPos: CGFloat = (displayHeight! / 2)
        
        var numOfItemsPlaced = 0
        var placeToRowNum = 1
        
        // loop for place rows
        for z in 1...numOfRows {
            if z == 1 {
                yPos = yPos - topPadding
            } else {
                yPos = yPos - (squareDimension + 10)
            }
            
            everyXPos = initialXPos
            
            // loop for place every square in line row
            for i in 1...numOfSquaresPerRow - 1 {
                if i != 1 {
                    everyXPos += initialXPos
                }
                
                itemSquare = SKSpriteNode(color: .black, size: CGSize(width: squareDimension, height: squareDimension))
                itemSquare?.anchorPoint = CGPoint(x: 0.5, y: 1)
                
                squarePosition = CGPoint(x: everyXPos, y: yPos)
                itemSquare?.position = squarePosition!
                inventoryScreen?.addChild(itemSquare!)
                // continue fill empty cells if no items in inventory
                if (player?.inventory.count)! == 0 || i > ((player?.inventory.count)!) { continue }
                
                if numOfItemsPlaced < player!.inventory.count {
                    if numOfItemsPlaced == (numOfSquaresPerRow - 1) {
                        placeToRowNum += 1
                    }
                    
                    if let playerItem = player?.inventory[i - 1] {
                        itemPic = SKSpriteNode(imageNamed: playerItem.assetName)
                        itemPic?.size = CGSize(width: squareDimension, height: squareDimension)
                        itemPic?.position = CGPoint(x: 0, y: -squareDimension / 2)
                        itemSquare?.addChild(itemPic!)
                        numOfItemsPlaced += 1
                        
                    }
                    
                }
                
            
            }

        }
        
        // place inventory capacity label at the bottom right and update its text
        let capacityLabel = inventoryScreen?.childNode(withName: "inventory-capacity") as? SKLabelNode
        capacityLabel?.position = CGPoint(x: everyXPos + (squareDimension / 2), y: yPos - squareDimension - 10)
        capacityLabel?.text = "Вместимость: \(player!.inventory.count)/\(player!.inventoryMaxCapacity)"
        done()
    }
}
