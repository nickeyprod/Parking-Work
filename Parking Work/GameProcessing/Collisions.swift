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
        
        print("collision")
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        print("didBeginContact entered for \(String(describing: bodyA.node!.name)) and \(String(describing: bodyB.node!.name))")
        
        let contactMask = (bodyA.categoryBitMask | bodyB.categoryBitMask)
 
        switch contactMask {
        case (playerCategory | lockCategory):
            if bodyA.node!.name != "playerNode" {
                tryOpenCarLock(of: (bodyA.node?.parent!.name)!, lockType: (bodyA.node?.name)!)
            }
            else if bodyB.node!.name != "playerNode" {
                tryOpenCarLock(of: (bodyB.node?.parent!.name)!, lockType: (bodyB.node?.name)!)
            }
        default:
            print("Some other contact occurred")
        }
    }
    
//    func didEnd(_ contact: SKPhysicsContact) {
//        let bodyA = contact.bodyA
//        let bodyB = contact.bodyB
//
//        print("didEndContact entered for \(String(describing: bodyA.node!.name)) and \(String(describing: bodyB.node!.name))")
//
//        let contactMask = (bodyA.categoryBitMask | bodyB.categoryBitMask)
//
//        switch contactMask {
//        case (playerCategory | lockCategory):
//            openCarWindow?.alpha = 0
//        default:
//            print("Some other contact occurred")
//        }
//    }
        
}
