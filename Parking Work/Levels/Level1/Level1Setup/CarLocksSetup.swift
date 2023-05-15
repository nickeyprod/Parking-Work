//
//  CarLocksSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//



import SpriteKit

// Level 1 Car Locks Setup
extension Level1 {
    
    func setupCarLocks() {
        
        // Old Copper locks
        let oldCopperDriverLock = oldCopper!.node?.childNode(withName: LOCK_TYPES.driverLock)
        let oldCopperPassengerLock = oldCopper!.node?.childNode(withName: LOCK_TYPES.passengerLock)
        
        // Old Copper locks complexity
        oldCopper!.locks[LOCK_TYPES.driverLock] = CAR_LOCK_COMPLEXITY_LIST.oldCopper.driverLock
        oldCopper!.locks[LOCK_TYPES.passengerLock] = CAR_LOCK_COMPLEXITY_LIST.oldCopper.passengerLock
        
        // OldCopper driver lock
        oldCopperDriverLock?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 20))
        oldCopperDriverLock?.physicsBody?.categoryBitMask = lockCategory
        oldCopperDriverLock?.physicsBody?.contactTestBitMask = playerCategory
        oldCopperDriverLock?.physicsBody?.affectedByGravity = false
        oldCopperDriverLock?.physicsBody?.isDynamic = true
        oldCopperDriverLock?.physicsBody?.allowsRotation = false
        oldCopperDriverLock?.physicsBody?.pinned = true
        
        // OldCopper passenger lock
        oldCopperPassengerLock?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 20))
        oldCopperPassengerLock?.physicsBody?.categoryBitMask = lockCategory
        oldCopperPassengerLock?.physicsBody?.contactTestBitMask = playerCategory
        oldCopperPassengerLock?.physicsBody?.affectedByGravity = false
        oldCopperPassengerLock?.physicsBody?.allowsRotation = false
        oldCopperPassengerLock?.physicsBody?.isDynamic = true
        oldCopperPassengerLock?.physicsBody?.pinned = true
        
        // Chowerler locks
        let chowerlerDriverLock = chowerler!.node?.childNode(withName: LOCK_TYPES.driverLock)
        let chowerlerPassengerLock = chowerler!.node?.childNode(withName: LOCK_TYPES.passengerLock)
        
        // Old Copper locks complexity
        chowerler!.locks[LOCK_TYPES.driverLock] = CAR_LOCK_COMPLEXITY_LIST.chowerler.driverLock
        chowerler!.locks[LOCK_TYPES.passengerLock] = CAR_LOCK_COMPLEXITY_LIST.chowerler.passengerLock
     
        // Chowerler driver lock
        chowerlerDriverLock?.physicsBody = SKPhysicsBody(rectangleOf: (chowerlerDriverLock?.frame.size)!)
        
        chowerlerDriverLock?.physicsBody?.categoryBitMask = lockCategory
        chowerlerDriverLock?.physicsBody?.contactTestBitMask = playerCategory
        chowerlerDriverLock?.physicsBody?.affectedByGravity = false
        chowerlerDriverLock?.physicsBody?.isDynamic = false
        chowerlerDriverLock?.physicsBody?.pinned = true
        chowerlerDriverLock?.physicsBody?.allowsRotation = false
        
        // Chowerler passenger lock
        chowerlerPassengerLock?.physicsBody = SKPhysicsBody(rectangleOf: (chowerlerPassengerLock?.frame.size)!)
        chowerlerPassengerLock?.physicsBody?.categoryBitMask = lockCategory
        chowerlerPassengerLock?.physicsBody?.contactTestBitMask = playerCategory
        chowerlerPassengerLock?.physicsBody?.affectedByGravity = false
        chowerlerPassengerLock?.physicsBody?.isDynamic = false
        chowerlerPassengerLock?.physicsBody?.pinned = true
        chowerlerPassengerLock?.physicsBody?.allowsRotation = false

    }
}
