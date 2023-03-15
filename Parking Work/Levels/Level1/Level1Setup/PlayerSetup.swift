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
        // player
        player = childNode(withName: "playerNode")

        player?.physicsBody?.categoryBitMask = playerCategory
        player?.physicsBody?.collisionBitMask = boundaryCategory | carCategory
        player?.zPosition = 10
    }
}


