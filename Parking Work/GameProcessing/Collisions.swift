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
        
//        print("didBeginContact entered for \(String(describing: bodyA.node!.name)) and \(String(describing: bodyB.node!.name))")
        
        let contactMask = (bodyA.categoryBitMask | bodyB.categoryBitMask)
 
        switch contactMask {
        case (playerCategory | lockCategory):
            
            if bodyA.node!.name != "playerNode" {
                currLockTarget = bodyA.node
            }
            if bodyB.node!.name != "playerNode" {
                currLockTarget = bodyB.node
            }
            
            // get lock type
            let lockType = currLockTarget?.name
            
            // initialize Car object
            currTargetCar = currLockTarget?.parent?.userData?.value(forKey: "self") as? Car

            // show message suggesting to open the target car
            // if distance not more than 150
            let playerPosition = player?.position
            let targetLockPosition = currLockTarget?.parent?.position

            let diffX = abs(playerPosition!.x) - abs(targetLockPosition!.x)
            let diffY = abs(playerPosition!.y) - abs(targetLockPosition!.y)
            if (abs(diffX) < 150 && abs(diffY) < 150 && !currTargetCar!.signaling) {
                self.showOpenCarMessage(of: currTargetCar!, lockType: lockType!)
                // raise anxiety bar
                raiseAnxiety(to: 0.5)
            }
            
        default:
            currLockTarget = nil
            print("Some other contact occurred")
        }
    }
    
}
