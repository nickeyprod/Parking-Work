//
//  M2Collisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.12.2023.
//

import Foundation

// Mission 2 Collision Processing
extension ParkingWorkGame {
    
    // Collision didBegin
    func M2CollisionProcess(contactMask: UInt32) {
        switch contactMask {
            // Detect when player is on a crosswalk
        case (playerCategory | crosswalkCategory):
            player?.onCrosswalk = true
        default:
            return
        }
    }
    
    // Collision didEnd
    func M2CollisionEndedProcess(contactMask: UInt32) {
        
    }
}
