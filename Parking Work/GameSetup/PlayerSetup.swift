//
//  PlayerSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import Foundation
import SpriteKit

// Mission 1 Player Setup
extension ParkingWorkGame {
    /// Getting player node from game scene, setting player categoryBitMask, collisionBitMask, for collision processing. Setting player zPosition, so it was above tilemap.
    func setupPlayer() {
    
        if let playerNode = childNode(withName: "playerNode") {
            if player == nil {
                player = Player(scene: self, name: "Фёдор", node: playerNode)
            } else {
                player?.node = playerNode
            }
            
        }

        player?.node!.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "user_staying_00"), size: player!.node!.frame.size)
        player?.node!.physicsBody?.affectedByGravity = false
        player?.node!.physicsBody?.allowsRotation = true
        
        player?.node?.physicsBody?.categoryBitMask = playerCategory
        player?.node?.physicsBody?.collisionBitMask = boundaryCategory | carCategory | trashBakCategory
        player?.node?.physicsBody?.mass = 84
        player?.node?.zPosition = 2
        
    }
}


