//
//  M2CrosswalkSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 22.07.2023.
//

import Foundation
import SpriteKit

// Mission 2 Cars Setup
extension Mission2 {
    func setupCrosswalk() {
        let crosswalkSprite = self.childNode(withName: "crosswalk-sprite") as? SKSpriteNode
        crosswalkSprite?.alpha = 0
        crosswalkSprite?.physicsBody = SKPhysicsBody(rectangleOf: crosswalkSprite!.size)
        crosswalkSprite?.physicsBody?.affectedByGravity = false
        crosswalkSprite?.physicsBody?.collisionBitMask = 0
        crosswalkSprite?.physicsBody?.categoryBitMask = crosswalkCategory
        crosswalkSprite?.physicsBody?.contactTestBitMask = playerCategory
    }
}
