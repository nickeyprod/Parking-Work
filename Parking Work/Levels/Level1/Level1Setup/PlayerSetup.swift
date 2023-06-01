//
//  PlayerSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import Foundation
import SpriteKit

// Level 1 Player Setup
extension Level1 {
    /// Getting player node from game scene, setting player categoryBitMask, collisionBitMask, for collision processing. Setting player zPosition, so it was above tilemap.
    func setupPlayer() {
        
        if let playerNode = childNode(withName: "playerNode") {
            player = Player(scene: self, name: "Фёдор", node: playerNode)
        }
        
        player?.node?.physicsBody?.categoryBitMask = playerCategory
        player?.node?.physicsBody?.collisionBitMask = boundaryCategory | carCategory | trashBakCategory
        player?.node?.physicsBody?.mass = 84
        player?.node?.zPosition = 10
    }
}


