//
//  SetupTrashCans.swift
//  Parking Work
//
//  Created by Николай Ногин on 19.05.2023.
//

import SpriteKit


// Level 1 Pigeons Setup
extension Level1 {
  
    func setupTrashBaks() {
        for bakNum in 0...3 {
            let trashBak = self.childNode(withName: "mysor_bak_" + "\(bakNum)") as? SKSpriteNode
            trashBak?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 140.184, height: 135.098))
            trashBak?.physicsBody?.restitution = 0
            trashBak?.physicsBody?.linearDamping = 1.0
            trashBak?.physicsBody?.angularVelocity = 0.1
            trashBak?.physicsBody?.angularDamping = 0.8
            trashBak?.anchorPoint = CGPoint(x: 0.5, y: 0.56)
            trashBak?.physicsBody?.affectedByGravity = false
            trashBak?.physicsBody?.isDynamic = true
            trashBak?.physicsBody?.mass = 139
            
            trashBak?.physicsBody?.categoryBitMask = trashBakCategory
            trashBak?.physicsBody?.collisionBitMask = carCategory | boundaryCategory | playerCategory | trashBakCategory
        }
    }
}
