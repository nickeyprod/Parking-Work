//
//  CarLocksSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//



import SpriteKit

// Car Locks Setup
extension ParkingWorkGame {
    func setupCarLocks() {
        // car locks
        let oldCopperDriver = oldCopper!.childNode(withName: "driver_lock")
        let oldCopperPassengerLock = oldCopper!.childNode(withName: "passenger_lock")
        
        // OldCopper driver lock
        oldCopperDriver?.physicsBody = SKPhysicsBody(rectangleOf: (oldCopperDriver?.frame.size)!)
        oldCopperDriver?.physicsBody?.categoryBitMask = lockCategory
        oldCopperDriver?.physicsBody?.contactTestBitMask = playerCategory
        oldCopperDriver?.physicsBody?.affectedByGravity = false
        oldCopperDriver?.physicsBody?.isDynamic = false
        
        // OldCopper passenger lock
        oldCopperPassengerLock?.physicsBody = SKPhysicsBody(rectangleOf: (oldCopperPassengerLock?.frame.size)!)
        oldCopperPassengerLock?.physicsBody?.categoryBitMask = lockCategory
        oldCopperPassengerLock?.physicsBody?.contactTestBitMask = playerCategory
        oldCopperPassengerLock?.physicsBody?.affectedByGravity = false
        oldCopperPassengerLock?.physicsBody?.isDynamic = false

    }
}
