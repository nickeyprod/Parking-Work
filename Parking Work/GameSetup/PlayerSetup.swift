//
//  PlayerSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import Foundation
import SpriteKit

// Player Setup
extension ParkingWorkGame {
    
    /// Getting player node from game scene, setting player categoryBitMask, collisionBitMask, for collision processing. Setting player zPosition, so it was above tilemap.
    func setupPlayer() {
        // player
        player = self.childNode(withName: "playerNode")
        player?.physicsBody?.categoryBitMask = playerCategory
        player?.physicsBody?.collisionBitMask = boundaryCategory | carCategory
        player?.zPosition = 10
    }
}


