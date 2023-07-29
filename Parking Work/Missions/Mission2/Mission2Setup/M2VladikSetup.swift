//
//  M2VladikSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 26.07.2023.
//

import Foundation
import SpriteKit

// Mission 2 Vladik Setup
extension Mission2 {
    func setupVladik() {
        let doorActionSprite = self.childNode(withName: "door-action") as? SKSpriteNode
        doorActionSprite?.physicsBody = SKPhysicsBody(rectangleOf: doorActionSprite!.size)
        doorActionSprite?.physicsBody?.affectedByGravity = false
        doorActionSprite?.physicsBody?.collisionBitMask = 0
        doorActionSprite?.physicsBody?.categoryBitMask = actionCategory
        doorActionSprite?.physicsBody?.contactTestBitMask = playerCategory
        
        //animate door action sprite
        let scaleArr: [SKAction] = [SKAction.scale(to: 1.2, duration: 1.2), SKAction.scale(to: 1.6, duration: 0.8)]
        doorActionSprite?.run(.repeatForever(SKAction.sequence(scaleArr)))
        
    }
}
