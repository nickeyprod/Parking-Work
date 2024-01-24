//
//  CollisionsDelegate.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Collisions Processing
extension ParkingWorkGame: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
//        print("didBeginContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
        
        let contactMask = getContactMask(contact.bodyA, contact.bodyB)
        
        // Process all mission's collisions
        processMissionCollisions(for: contactMask)
        
        // Process general game collisions
        processGeneralCollisions(for: contactMask, and: contact)

    }
    
    func didEnd(_ contact: SKPhysicsContact) {
//        print("didEndContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
                
        let contactMask = getContactMask(contact.bodyA, contact.bodyB)

        // Process end of anxiety circles collisions
        anxietyCirclesCollisionEndedProcess(for: contactMask)
        
        // Process end of crosswalk's collisions
        crosswalkCollisionEndedProcess(contactMask: contactMask)
        
    }
    
    // just returns contact mask
    func getContactMask(_ bodyA: SKPhysicsBody, _ bodyB: SKPhysicsBody) -> UInt32 { (bodyA.categoryBitMask | bodyB.categoryBitMask) }
    
}
