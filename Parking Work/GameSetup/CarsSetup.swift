//
//  CarsSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Cars Setup
extension ParkingWorkGame {
    
    func setupCars() {
        
        // Old Copper
        oldCopper = self.childNode(withName: Cars.OldCopper.rawValue)

        oldCopper?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Cars.OldCopper.rawValue), size: CGSize(width: 460, height: 200))
        oldCopper?.physicsBody?.categoryBitMask = carCategory
        oldCopper?.physicsBody?.affectedByGravity = false
        oldCopper?.physicsBody?.isDynamic = false
        oldCopper?.zPosition = 1
        
        // Chowerler
        chowerler = self.childNode(withName: Cars.Chowerler.rawValue)
        chowerler?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Cars.Chowerler.rawValue), size: CGSize(width: 258.363, height: 506.244))

        chowerler?.physicsBody?.categoryBitMask = carCategory
        chowerler?.physicsBody?.affectedByGravity = false
        chowerler?.physicsBody?.isDynamic = false
        chowerler?.zPosition = 1
    }
}
