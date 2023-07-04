//
//  SetupItemsOnMission.swift
//  Parking Work
//
//  Created by Николай Ногин on 02.07.2023.
//

import SpriteKit

// Mission 1 Completion Rules Setup
extension Mission1 {
    
    func fillItemsOfMission() {
        
        // pick lock
        if let pickLockNode = childNode(withName: "pick-lock") as? SKSpriteNode {
            pickLockNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "usual_picklock"), size: CGSize(width: 35, height: 35))
            pickLockNode.physicsBody?.categoryBitMask = gameItemCategory
            pickLockNode.physicsBody?.contactTestBitMask = playerCategory
            pickLockNode.physicsBody?.collisionBitMask = 0
            pickLockNode.physicsBody?.affectedByGravity = false
            
            let pickLock = GameItem(
                id: ITEMS_TYPES.PICKLOCKS.usual_picklock.id,
                name: ITEMS_TYPES.PICKLOCKS.usual_picklock.name,
                node: pickLockNode,
                type: ITEMS_TYPES.PICKLOCKS.TYPE,
                assetName: ITEMS_TYPES.PICKLOCKS.usual_picklock.assetName,
                description: ITEMS_TYPES.PICKLOCKS.usual_picklock.description,
                properties: ITEMS_TYPES.PICKLOCKS.usual_picklock.properties
            )
            
            itemsOnMission.append(pickLock)
            
            pickLockNode.userData = NSMutableDictionary()
            pickLockNode.userData?.setValue(pickLock.self, forKeyPath: "self")
        }
        
        // pick lock 2
        if let pickLockNode2 = childNode(withName: "pick-lock2") as? SKSpriteNode {
            pickLockNode2.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: ITEMS_TYPES.PICKLOCKS.professional_picklock.assetName), size: CGSize(width: 35, height: 35))
            pickLockNode2.physicsBody?.categoryBitMask = gameItemCategory
            pickLockNode2.physicsBody?.contactTestBitMask = playerCategory
            pickLockNode2.physicsBody?.collisionBitMask = 0
            pickLockNode2.physicsBody?.affectedByGravity = false
            
            let pickLock2 = GameItem(
                id: ITEMS_TYPES.PICKLOCKS.professional_picklock.id,
                name: ITEMS_TYPES.PICKLOCKS.professional_picklock.name,
                node: pickLockNode2,
                type: ITEMS_TYPES.PICKLOCKS.TYPE,
                assetName: ITEMS_TYPES.PICKLOCKS.professional_picklock.assetName,
                description: ITEMS_TYPES.PICKLOCKS.professional_picklock.description,
                properties: ITEMS_TYPES.PICKLOCKS.professional_picklock.properties
            )
            
            itemsOnMission.append(pickLock2)
            
            pickLockNode2.userData = NSMutableDictionary()
            pickLockNode2.userData?.setValue(pickLock2.self, forKeyPath: "self")
        }
        
    }
    
}
