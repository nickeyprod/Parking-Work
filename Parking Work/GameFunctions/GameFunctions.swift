//
//  GamePlayFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// General Game Functions
extension ParkingWorkGame {
    
    // this updates position of the player on minimap
    func updateMiniMapPlayerPos() {

        let scaleWidthFactor = tileMapWidth! / miniMapWidth!
        let scaleHeightFactor = tileMapHeight! / miniMapHeight!

        let miniMapX = player!.node!.position.x / scaleWidthFactor * miniMapScaleFactor
        let minimapY = player!.node!.position.y / scaleHeightFactor * miniMapScaleFactor
        
        miniMapSprite?.position = CGPoint(x: -miniMapX, y: -minimapY)
    }
    
    func checkDistanceBetweenPlayerAndGameItem() {
        let playerPosition = player?.node?.position
        let targetGameItem = player?.currTargetItem?.node.position
        
        let diffX = abs(playerPosition!.x) - abs(targetGameItem!.x)
        let diffY = abs(playerPosition!.y) - abs(targetGameItem!.y)

        if (abs(diffX) > 30 || abs(diffY) > 30) {
            hideActionMessage()
        }
    
        // lock target clearing
        if (abs(diffX) > 45 || abs(diffY) > 45) {
            player?.currTargetItem = nil
            hideTargetWindow()
        }
    }

    func checkDistanceBetweenPlayerAndTargetLock() {
        let playerPosition = player?.node?.position
        let targetCarPosition = player?.currTargetCar!.node?.position
        
        let diffX = abs(playerPosition!.x) - abs(targetCarPosition!.x)
        let diffY = abs(playerPosition!.y) - abs(targetCarPosition!.y)

        if (abs(diffX) > 150 || abs(diffY) > 150) {
            if player?.currTargetCar?.stolen == true {
                self.enterToCarBtn?.removeFromParent()
                self.enterToCarBtn = nil
            } else {
                hideActionMessage()
            }
            
        }
        // lock target clearing
        if (abs(diffX) > 420 || abs(diffY) > 420) {
            player?.currTargetLock = nil
            player!.currTargetCar = nil
            hideTargetWindow()
        }
        
        if player!.currTargetCar == nil {
            return
        }
        
        // check for rising anxiety
        if (abs(diffX) < (player!.currTargetCar?.firstAnxietyCircle)! || abs(diffY) < (player!.currTargetCar?.firstAnxietyCircle)! ) {
            playerInFirstCircle = true
            playerInCircleOfCar = player?.currTargetCar?.node
        } else {
            playerInFirstCircle = false
        }
        
        if (abs(diffX) < (player!.currTargetCar?.secondAnxietyCircle)! || abs(diffY) < (player!.currTargetCar?.secondAnxietyCircle)! ) {
            playerInSecondCircle = true
            playerInCircleOfCar = player?.currTargetCar?.node
        } else {
            playerInSecondCircle = false
        }
        
        if (abs(diffX) < (player!.currTargetCar?.thirdAnxietyCircle)! || abs(diffY) < (player!.currTargetCar?.thirdAnxietyCircle)! ) {
            playerInThirdCircle = true
            playerInCircleOfCar = player?.currTargetCar?.node
        } else {
            playerInThirdCircle = false
        }
            
//            case (playerCategory | firstCircleCategory):
//                playerInFirstCircle = true
//                playerInCircleOfCar = contact.bodyB.node?.parent
//                raiseAnxiety(to: 1)
//            case (playerCategory | secondCircleCategory):
//                playerInSecondCircle = true
//                playerInCircleOfCar = contact.bodyB.node?.parent
//                raiseAnxiety(to: 0.5)
//            case (playerCategory | thirdCircleCategory):
//                playerInThirdCircle = true
//                playerInCircleOfCar = contact.bodyB.node?.parent
//                raiseAnxiety(to: 0.3)
    
    }
    
    // rising anxiety bar (144max)
    func raiseAnxiety(to num: CGFloat) {
        // do not raise anxiety during showing tutorial messages
        if canMoveCamera == false || player!.isSittingInCar { return }
        
        canReduceAnxiety = false
        
        let futureWidth = anxietyLevel + num
        
        if futureWidth > 144.0 {
            anxietyLevel = 144
        } else {
            anxietyLevel = futureWidth
        }
        anxietyBar!.run(SKAction.resize(toWidth: anxietyLevel, duration: 0.2)) {
            self.canReduceAnxiety = true
        }
    }
    
    // reduce anxiety
    func reduceAnxiety(to num: CGFloat) {
        canReduceAnxiety = false
        
        let futureWidth = anxietyLevel - num
        
        if futureWidth < 0 {
            anxietyLevel = 0
        } else {
            anxietyLevel = futureWidth
        }
        anxietyBar!.run(SKAction.resize(toWidth: anxietyLevel, duration: 0.2)) {
            self.canReduceAnxiety = true
        }
 
    }
    
    // Get random point outside of the game world ends
    func getRandomPointOutsideGameWorld() -> CGPoint {
        let maxX = Int((tileMapWidth! / 2) + 100)
        let maxY = Int((tileMapHeight! / 2) + 100)
        
        let posXTop = Int.random(in: maxX...maxX + 500)
        let negativeXBottom = Int.random(in: (-maxX - 500)...(-maxX))
        let posYTop = Int.random(in: maxY...maxY + 500)
        let negativeYBottom = Int.random(in: -maxY - 500...(-maxY))
        
        let r = Int.random(in: 0...1)
        let point: CGPoint?
        if r == 0 {
            point = CGPoint(x: posXTop, y: posYTop)
        } else {
            point = CGPoint(x: negativeXBottom, y: negativeYBottom)
        }
        
        return point!
    }
    
    func adjustSizeOfTargetWindow(to height: CGFloat, width: CGFloat? = nil) {
        self.targetWindow?.run(SKAction.resize(toHeight: height, duration: 0.2))
        if width != nil {
            self.targetWindow?.run(SKAction.resize(toWidth: width!, duration: 0.2))
        }
        
    }
    
    func getHeightOfAllNodesInTargetSquare() -> CGFloat {
        var height: CGFloat = 0
        for node in self.targetWindow!.children {
            height += node.frame.height
        }
        return height + 6
    }
    
    func fillItemsOfMission() {
        
        // pick lock
        if let pickLockNode = childNode(withName: "pick-lock") as? SKSpriteNode {
            pickLockNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "usual_picklock"), size: CGSize(width: 35, height: 35))
            pickLockNode.physicsBody?.categoryBitMask = gameItemCategory
            pickLockNode.physicsBody?.contactTestBitMask = playerCategory
            pickLockNode.physicsBody?.collisionBitMask = 0
            pickLockNode.physicsBody?.affectedByGravity = false
            
            let pickLock = GameItem(name: ITEMS_TYPES.PICKLOCKS.usual_picklock.name, node: pickLockNode, type: ITEMS_TYPES.PICKLOCKS.TYPE, assetName: ITEMS_TYPES.PICKLOCKS.usual_picklock.assetName, description: ITEMS_TYPES.PICKLOCKS.usual_picklock.description)
            
            itemsOnMission.append(pickLock)
            
            pickLockNode.userData = NSMutableDictionary()
            pickLockNode.userData?.setValue(pickLock.self, forKeyPath: "self")
        }
        
    }
    
    func switchActionMessageType(to type: MESSAGES_TYPES) {
        actionMessageType = type
    }
    
    func closeInventory() {
        isInventoryOpened = false
        let moveAction = SKAction.move(to: CGPoint(x: (displayWidth! / 2) + 20, y: (inventoryScreen?.position.y)!), duration: 0.5)
        inventoryScreen?.run(moveAction)
        
        // hide item's description window
        hideDescriptionOfItem()
    }
    
    func openInventory() {
        isInventoryOpened = true
        fillInventoryWithItemSquares {
            let moveAction = SKAction.move(to: CGPoint(x: 0, y: (inventoryScreen?.position.y)!), duration: 0.5)
            inventoryScreen?.run(moveAction)
        }
        
    }
    
    func showDescriptionOf(item: GameItem, touchedNode: SKNode) {
        if inventoryScreen?.childNode(withName: "inventory-item-description") != nil {
            self.hideDescriptionOfItem()
            return
        }
        
        var heightOfAllLabels: CGFloat = 0
        let topPadding: CGFloat = 15
        let bottomPadding: CGFloat = 15
        
        let strokeRect = CGRect(origin: CGPoint(x: 0, y: 0), size:  CGSize(width: touchedNode.frame.width - 2, height: touchedNode.frame.height - 2))
        let strokePath = CGPath(rect: strokeRect, transform: .none)
        let strokeShape = SKShapeNode(path: strokePath, centered: true)
        strokeShape.position = CGPoint(x: 0, y: -touchedNode.frame.height / 2)
        strokeShape.strokeColor = .blue
        strokeShape.lineWidth = 2
        strokeShape.alpha = 0.6
        strokeShape.name = "inventory-item-selection"
        touchedNode.parent?.addChild(strokeShape)
        
        let descriptionWindow = SKSpriteNode(color: .black, size: CGSize(width: 180, height: 150))
        descriptionWindow.name = "inventory-item-description"
        descriptionWindow.anchorPoint = CGPoint(x: 1, y: 1)
        descriptionWindow.position =  CGPoint(x: touchedNode.parent!.position.x, y: touchedNode.parent!.position.y - (touchedNode.parent?.frame.height)!)
        self.inventoryScreen?.addChild(descriptionWindow)
        
        // item name
        let itemName = SKLabelNode(text: item.name)
        itemName.verticalAlignmentMode = .center
        itemName.horizontalAlignmentMode = .center
        itemName.lineBreakMode = .byWordWrapping
        itemName.numberOfLines = 0
        itemName.preferredMaxLayoutWidth = descriptionWindow.frame.width
        itemName.fontName = FONTS.AmericanTypewriter
        itemName.fontSize = 12
        itemName.position = CGPoint(x: -descriptionWindow.frame.width / 2, y: -topPadding)
        descriptionWindow.addChild(itemName)
        
        heightOfAllLabels += itemName.frame.height
        
        let itemDescription = SKLabelNode(text: item.description)
        itemDescription.verticalAlignmentMode = .top
        itemDescription.horizontalAlignmentMode = .center
        itemDescription.lineBreakMode = .byWordWrapping
        itemDescription.numberOfLines = 0
        itemDescription.preferredMaxLayoutWidth = descriptionWindow.frame.width
        itemDescription.fontName = FONTS.Baskerville
        itemDescription.fontSize = 12
        itemDescription.position = CGPoint(x: -descriptionWindow.frame.width / 2, y: itemName.position.y - (itemName.frame.height / 2))
        descriptionWindow.addChild(itemDescription)
        
        heightOfAllLabels += itemDescription.frame.height
        
        descriptionWindow.size = CGSize(width: 180, height: heightOfAllLabels + bottomPadding)
    }
    
    func hideDescriptionOfItem() {
        self.inventoryScreen?.childNode(withName: "inventory-item-description")?.removeFromParent()
        self.inventoryScreen?.children.forEach({ square in
            square.childNode(withName: "inventory-item-selection")?.removeFromParent()
        })
    }
    
//    func getTargetLock(of car: Car, lockType: String) -> CarLock? {
//        for lock in car.locks {
//            if lock?.type == lockType {
//                return lock
//            }
//        }
//        return nil
//    }

}

