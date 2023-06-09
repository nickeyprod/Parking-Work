//
//  UICreation.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

// User Interface Creation Game Functions
extension ParkingWorkGame {
    
    // Creates UI Buttons
    func createUIButtons() {
 
        // task button
        let taskBtn = SKShapeNode(circleOfRadius: 14)
        taskBtn.name = "ui-taskBtn"
        taskBtn.fillColor = UIColor.gray
        taskBtn.alpha = 0.75
        taskBtn.zPosition = 11
        taskBtn.position = CGPoint(x: -displayWidth! / 2 + 150, y: displayHeight! / 2 - 26)
        self.taskButton = taskBtn
        
        //  task button label
        let taskBtnLabel = SKLabelNode(text: "?")
        taskBtnLabel.name = "ui-taskLabel"
        taskBtnLabel.fontSize = 20
        taskBtnLabel.fontName = "Baskerville-bold"
        taskBtnLabel.fontColor = .white
        taskBtnLabel.horizontalAlignmentMode = .center
        taskBtnLabel.verticalAlignmentMode = .center
        
        taskBtn.addChild(taskBtnLabel)
        
        self.cameraNode?.addChild(taskBtn)
        
        // menu button
        let menuBtn = SKShapeNode(rectOf: CGSize(width: 30, height: 30), cornerRadius: 6)
        menuBtn.name = "ui-menuBtn"
        menuBtn.fillColor = UIColor.gray
        menuBtn.alpha = 0.75
        menuBtn.zPosition = 10
        menuBtn.position = CGPoint(x: displayWidth! / 2 - 40, y: displayHeight! / 2 - 26)
        
        self.menuButton = menuBtn
        
        // menu button label
        let menuBtnLabel = SKLabelNode(text: "\u{23F8}")
        menuBtnLabel.name = "ui-menuLabel"
        menuBtnLabel.fontSize = 32
        menuBtnLabel.fontName = "Baskerville-bold"
        menuBtnLabel.fontColor = .white
        menuBtnLabel.horizontalAlignmentMode = .center
        menuBtnLabel.verticalAlignmentMode = .center
        
        menuBtn.addChild(menuBtnLabel)
        
        self.cameraNode?.addChild(menuBtn)
        
        // run button
        let runBtn = SKShapeNode(circleOfRadius: 38)
        self.runButton = runBtn
        runBtn.name = "ui-runBtn"
        runBtn.fillColor = UIColor.brown
        runBtn.alpha = 0.75
        runBtn.zPosition = 10
        runBtn.position = CGPoint(x: (displayWidth! / 2) - 90, y: -(displayHeight! / 2) + 90)
        
        let shoe = SKSpriteNode(texture: SKTexture(imageNamed: "shoe"))
        shoe.name = "ui-runBtnImg"
        shoe.size.width = 50
        shoe.size.height = 50
        
        runBtn.addChild(shoe)
        
        self.cameraNode?.addChild(runBtn)
        
        // inventory bag
        if let inventoryBag = UIImage(named: "sport-bag") {
            let inventorySprite = SKSpriteNode(texture: SKTexture(image: inventoryBag))
            self.inventoryButton = inventorySprite
            inventorySprite.zPosition = 10
            inventorySprite.name = "ui-inventory-btn"
            self.cameraNode?.addChild(inventorySprite)
            inventorySprite.size = CGSize(width: 52, height: 52)
            inventorySprite.position = CGPoint(x: -displayWidth! / 2 + 40, y: 0)
        }
        
    }
    
    func createIcons() {
        
        // money
        if let moneyIcon = UIImage(named: "money") {
            let moneySprite = SKSpriteNode(texture: SKTexture(image: moneyIcon))
            self.taskScreen?.addChild(moneySprite)
            moneySprite.size = CGSize(width: 25, height: 25)
            moneySprite.position = CGPoint(x: displayWidth! / 2 - 20, y: displayHeight! / 2 - 30)
        }
        
        let moneyLabel = SKLabelNode(text: String(player!.money))
        moneyLabel.fontName = "Menlo-regular"
        moneyLabel.fontSize = 16
        self.taskScreen?.addChild(moneyLabel)
        moneyLabel.horizontalAlignmentMode = .right
        moneyLabel.position = CGPoint(x: displayWidth! / 2 - 36, y: displayHeight! / 2 - 40)
        
        // reputation
        let reputation = SKLabelNode(text: "Репутация:  \(player!.reputation)")
        reputation.fontName = "Gill Sans"
        reputation.fontSize = 18
        reputation.horizontalAlignmentMode = .left
        reputation.position = CGPoint(x: -displayWidth! / 2 + 16, y: -displayHeight! / 2 + 14)
        self.taskScreen?.addChild(reputation)
        
    }
    
    
    // Creates anxiety bar
    func createAnxietyBar() {
        
        let cropShape = SKCropNode()
        cropShape.zPosition = 15
        cropShape.position = CGPoint(x: -(displayWidth! / 2) + 100, y: -(displayHeight! / 2) + 20)
        
        // shape for stroke
        let outerShape = SKShapeNode(rectOf: CGSize(width: 140, height: 17), cornerRadius: 6)
        outerShape.zPosition = 15
        outerShape.strokeColor = .white
        outerShape.lineWidth = 2
        
        outerShape.position = CGPoint(x: -(displayWidth! / 2) + 100, y: -(displayHeight! / 2) + 20)

        let maskShape = SKShapeNode(rectOf: CGSize(width: 140, height: 17), cornerRadius: 8)
        maskShape.fillColor = .black
        cropShape.maskNode = maskShape
        
        let innerSprite = SKSpriteNode(color: .blue, size: CGSize(width: 0, height: 20) )
        innerSprite.anchorPoint = CGPoint(x: 0, y: 0)
        
        innerSprite.position = CGPoint(x: -(maskShape.frame.width / 2), y: -(maskShape.frame.height / 2) )
            
        anxietyOuterShape = outerShape
        anxietyInnerSprite = innerSprite
        
        cropShape.addChild(innerSprite)
        self.cameraNode?.addChild(cropShape)
        self.cameraNode?.addChild(outerShape)
        
        // set for global access
        self.anxietyBar = innerSprite
        
    }
    
    // Creates mini map
    func createMinimap() {
            
        let mapWidth: CGFloat = 120
        let mapHeight: CGFloat = 100
        
        let mapPos = CGPoint(x: -displayWidth! / 2 + 70, y: displayHeight! / 2 - 70)
        
        let cropNode = SKCropNode()
        
        cropNode.zPosition = 20
        cropNode.position = mapPos

        let mask = SKShapeNode(circleOfRadius: 60)
        
        mask.fillColor = UIColor.white
        mask.alpha = 0.8

        cropNode.maskNode = mask
        
        // border around minimap
        let strokeShape = SKShapeNode(circleOfRadius: 60)
        strokeShape.name = "mini-map-stroke"
        strokeShape.position = mapPos
        strokeShape.zPosition = 20
        strokeShape.lineWidth = 2
        strokeShape.alpha = 0.7
        strokeShape.strokeColor = UIColor.black


        // set mini map mission sprite
        miniMapSprite = SKSpriteNode(texture: SKTexture(image: UIImage(named: "mission\(missionNum)_minimap")!))
        miniMapSprite?.size.width = mapWidth
        miniMapSprite?.size.height = mapHeight
        
        miniMapWidth = miniMapSprite?.frame.width
        miniMapHeight = miniMapSprite?.frame.height

        cropNode.addChild(miniMapSprite!)
        miniMapSprite?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        miniMapSprite?.zPosition = 0
        
        self.cameraNode?.addChild(cropNode)
        self.cameraNode?.addChild(strokeShape)
        
        // plus minus buttons
//        let plusBtn = SKLabelNode(text: "+")
//        plusBtn.zPosition = 20
//        let minusBtn = SKLabelNode(text: "-")
//        minusBtn.zPosition = 20
//
//        plusBtn.fontSize = 20
//        minusBtn.fontSize = 20
//
//        plusBtn.position = CGPoint(x: -displayWidth! / 2 + 100 + 20, y: (displayHeight! / 2) - 80 - (miniMapHeight! / 2 + 25))
//
//        minusBtn.position = CGPoint(x: (-displayWidth! / 2 ) + 100 - 20, y: (displayHeight! / 2) - 80 - (miniMapHeight! / 2 + 25))
//        self.cameraNode?.addChild(plusBtn)
//        self.cameraNode?.addChild(minusBtn)
        
        self.miniMapSprite?.setScale(miniMapScaleFactor)
        
        // add player dot to mini map
        let miniMapDot = SKShapeNode(circleOfRadius: 3)
        miniMapDot.fillColor = .orange
        cropNode.addChild(miniMapDot)
        
        self.player?.miniMapDot = miniMapDot
        
        // set crop node globally for adding car dots on Mission init class
        self.miniMapCropNode = cropNode
        self.miniMapCropNode?.zPosition = 2
    
    }

}
