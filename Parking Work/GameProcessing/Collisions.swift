//
//  CollisionsProcessing.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Collisions Processing
extension ParkingWorkGame: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        print("didBeginContact entered for \(String(describing: bodyA.node!.name)) and \(String(describing: bodyB.node!.name))")
        
        let contactMask = (bodyA.categoryBitMask | bodyB.categoryBitMask)
 
        switch contactMask {
        case (playerCategory | lockCategory):
            
            if bodyA.node!.name != "playerNode" {
                currLockTarget = bodyA.node
            }
            else if bodyB.node!.name != "playerNode" {
                currLockTarget = bodyB.node
            }
            
            // get car name, lock type and lock complexity
            let carName = currLockTarget?.parent!.name
            let lockType = currLockTarget?.name
            let lockComplexity = CAR_LIST[carName!]?[lockType!]
            
            // initialize targetCar object
            currTargetCar = TargetCar(carName: carName!, lockType: lockType!, lockComplexity: lockComplexity!)
            
            // show message suggesting to open the target car
            self.showOpenCarMessage(of: currTargetCar!)
        default:
            currLockTarget = nil
            print("Some other contact occurred")
        }
    }
    
}
