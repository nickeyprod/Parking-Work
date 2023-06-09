//
//  WorldSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Mission 1 World Bounds Setup
extension Mission1 {
    
    func setupWorldBoundaries() {
        // player collides with this `end of the world` boundaries
        for i in 0...8 {
            let worldBoundary = childNode(withName: "boundary\(i)")
            worldBoundary?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (worldBoundary?.frame.width)!, height: (worldBoundary?.frame.height)!))
            worldBoundary?.physicsBody?.categoryBitMask = boundaryCategory
            worldBoundary?.physicsBody?.affectedByGravity = false
            worldBoundary?.physicsBody?.isDynamic = false
            worldBoundary?.alpha = 0
        }
    }
    
}