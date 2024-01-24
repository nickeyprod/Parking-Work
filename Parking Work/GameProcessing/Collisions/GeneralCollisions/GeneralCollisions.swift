//
//  GeneralCollisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 29.12.2023.
//

import Foundation
import SpriteKit

// Process General Collisions
extension ParkingWorkGame {
    // Process general game collisions
    func processGeneralCollisions(for contactMask: UInt32, and contact: SKPhysicsContact) {
        
        // Process car's anxiety circle's collisions
        anxietyCirclesCollisionProcess(for: contactMask)
        
        // Process Game Item collisions
        gameItemCollisionsProcess(for: contactMask, and: contact)
        
        // Process trash tank's collisions
        trashTankCollisionProcess(for: contactMask, and: contact)
        
        // Process car's collisions
        carCollisionsProcess(for: contactMask)
        
        // Process car-lock's collisions
        carLockCollisionsProcess(for: contactMask, and: contact)
        
        // Process pigeon's collisions
        pigeonCollisionsProcess(for: contactMask, and: contact)
        
        // Process crosswalk's collisions
        crosswalkCollisionProcess(for: contactMask)
    }
    
}
