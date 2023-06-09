//
//  setupPigeon.swift
//  Parking Work
//
//  Created by Николай Ногин on 17.04.2023.
//


import SpriteKit

// Mission 1 Pigeons Setup
extension Mission1 {

    func setupPigeons() {
        
        // pigeon collides with player
        for i in 1...2 {
            let pigeon = childNode(withName: "pigeon_\(i)")
            pigeon?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "pigeon_1"), size: (pigeon?.frame.size)!)
            pigeon?.physicsBody?.categoryBitMask = pigeonCategory
            pigeon?.physicsBody?.contactTestBitMask = playerCategory | carCategory | trashBakCategory
            pigeon?.physicsBody?.affectedByGravity = false
            pigeon?.physicsBody?.isDynamic = false
            pigeon?.zPosition = 20
        

        }
     
        
    }

}
