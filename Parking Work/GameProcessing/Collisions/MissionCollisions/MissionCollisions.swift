//
//  MissionCollisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 29.12.2023.
//

import Foundation

// Process Mission Collisions
extension ParkingWorkGame {
    // Process mission's collisions
    func processMissionCollisions(for contactMask: UInt32) {
        switch self.missionNum {
        case 1:
            // Mission 1 Collisions
            M1CollisionProcess(contactMask: contactMask)
        case 2:
            // Mission 2 Collisions
            M2CollisionProcess(contactMask: contactMask)
        default:
            return
        }
    }
}
