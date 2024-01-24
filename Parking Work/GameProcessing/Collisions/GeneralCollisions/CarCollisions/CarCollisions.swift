//
//  CarCollisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.12.2023.
//

import Foundation

extension ParkingWorkGame {
    func carCollisionsProcess(for contactMask: UInt32) {
        switch contactMask {
        case (carCategory | carCategory):
            if !canPlayCrashSound { return }
            else {
                canPlayCrashSound = false
            }
            
            switch Int.random(in: 1...2) {
            case 1:
                self.run(CarCollisionSounds.car_collision_01.action)
            case 2:
                self.run(CarCollisionSounds.car_collision_02.action)
            default:
                return
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
                self.canPlayCrashSound = true
            }
            
        case (carCategory | boundaryCategory):
            if !canPlayBoundaryCrashSound { return }
            else {
                canPlayBoundaryCrashSound = false
            }
            
            self.run(CarCollisionSounds.car_collision_01.action)
            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
                self.canPlayBoundaryCrashSound = true
            }
        default:
            return
            
        }

    }
}
