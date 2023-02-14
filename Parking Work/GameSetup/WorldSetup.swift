//
//  WorldSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// World Bounds Setup
extension ParkingWorkGame {
    
    func setupWorldBoundaries() {
        // player collides with this `end of the world` boundaries
        for i in 0...6 {
            let worldBoundary = self.childNode(withName: "boundary\(i)")
            worldBoundary?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (worldBoundary?.frame.width)!, height: (worldBoundary?.frame.height)!))
            worldBoundary?.physicsBody?.categoryBitMask = boundaryCategory
            worldBoundary?.physicsBody?.affectedByGravity = false
            worldBoundary?.physicsBody?.isDynamic = false
            worldBoundary?.alpha = 0
        }
    
    }
    
}
