//
//  PigeonsSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 17.04.2023.
//


import SpriteKit

// Game Pigeons Setup
extension ParkingWorkGame {

    func setupPigeons() {
        
        // Pigeons contacting with player
        self.children.filter({ $0.name == "pigeon" }).forEach({
            $0.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "pigeon_1"), size: $0.frame.size)
            $0.physicsBody?.categoryBitMask = pigeonCategory
            $0.physicsBody?.contactTestBitMask = playerCategory | carCategory | trashBakCategory
            $0.physicsBody?.affectedByGravity = false
            $0.physicsBody?.isDynamic = false
            $0.zPosition = 20
            
        })
    }
}
