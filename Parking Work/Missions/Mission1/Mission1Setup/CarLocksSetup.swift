//
//  CarLocksSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//



import SpriteKit

// Mission 1 Car Locks Setup
extension Mission1 {
    
    // setups lock objects and their physic bodies for all cars on level
    func setupLocksForAllCars() {
        // setup locks for every car on level
        for car in carsOnLevel {
            // setup all found lock types
            for lockType in LOCK_TYPES_LIST {
                // get car lock node and car lock complexity
                if let carLockNode = car?.node?.childNode(withName: lockType),
                    let carName = car?.name {
                    
                    let carLock = CarLock(
                        type: lockType,
                        node: carLockNode,
                        complexity: (LOCK_COMPLEXITIES[carName]?[lockType])!,
                        unlocked: false,
                        jammed: false
                    )
                    
                    carLockNode.userData = NSMutableDictionary()
                    carLockNode.userData?.setValue(carLock.self, forKeyPath: "self")
            
                    // setup lock node
                    setupPhysicBody(for: carLockNode, lockType: lockType)
                    
                    // setup lock object
                    car?.locks.append(carLock)
                }
            }
        }
    }
    
    func setupPhysicBody(for lockNode: SKNode, lockType: String) {
        // setup physics body for current car lock node
        lockNode.physicsBody = SKPhysicsBody(rectangleOf: lockNode.frame.size)
        lockNode.physicsBody?.categoryBitMask = lockCategory
        lockNode.physicsBody?.contactTestBitMask = playerCategory
        lockNode.physicsBody?.affectedByGravity = false
        lockNode.physicsBody?.allowsRotation = false
        lockNode.physicsBody?.isDynamic = true
        lockNode.physicsBody?.pinned = true
    }
}
