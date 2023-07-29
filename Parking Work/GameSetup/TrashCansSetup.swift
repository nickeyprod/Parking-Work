//
//  SetupTrashCans.swift
//  Parking Work
//
//  Created by Николай Ногин on 19.05.2023.
//

import SpriteKit

// Game Trash Cans Setup
extension ParkingWorkGame {
  
    func setupTrashBaks() {
        self.children.filter({ $0.name == "mysor_bak" }).forEach({
            $0.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 140.184, height: 135.098))
            $0.physicsBody?.restitution = 0
            $0.physicsBody?.linearDamping = 1.0
            $0.physicsBody?.angularVelocity = 0.1
            $0.physicsBody?.angularDamping = 0.8
            ($0 as? SKSpriteNode)?.anchorPoint = CGPoint(x: 0.5, y: 0.56)
            $0.physicsBody?.affectedByGravity = false
            $0.physicsBody?.isDynamic = true
            $0.physicsBody?.mass = 139
            
            $0.physicsBody?.categoryBitMask = trashBakCategory
            $0.physicsBody?.collisionBitMask = carCategory | boundaryCategory | playerCategory | trashBakCategory
        })
    }
}
