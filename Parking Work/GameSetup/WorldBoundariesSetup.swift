//
//  WorldBoundariesSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Game World Bounds Setup
extension ParkingWorkGame {
    
    func setupWorldBoundaries() {
        self.children.filter({ $0.name == "boundary" }).forEach({
            $0.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: $0.frame.width, height: $0.frame.height))
            $0.physicsBody?.categoryBitMask = boundaryCategory
            $0.physicsBody?.affectedByGravity = false
            $0.physicsBody?.isDynamic = false
            $0.alpha = 0
        })
    }
    
}
