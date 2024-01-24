//
//  TrashTankCollisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.12.2023.
//

import Foundation
import SpriteKit

extension ParkingWorkGame {
    func trashTankCollisionProcess(for contactMask: UInt32, and contact: SKPhysicsContact) {
        switch contactMask {
        case (trashBakCategory | carCategory):
            self.run(CarCollisionSounds.plastic_hit.action)
        case (trashBakCategory | pigeonCategory):
            playerAndPigeonContact(contact.bodyA, contact.bodyB)
        default:
            return
        }
    }
}
