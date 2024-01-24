//
//  GameItemCollisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.12.2023.
//

import Foundation
import SpriteKit

// Game Item's Collision Processing
extension ParkingWorkGame {
    func gameItemCollisionsProcess(for contactMask: UInt32, and contact: SKPhysicsContact) {

        switch contactMask {
        case (playerCategory | gameItemCategory):
            playerAndGameItemContact(contact.bodyA, contact.bodyB)
        default:
            return
        }
    }
    
    func playerAndGameItemContact (_ bodyA: SKPhysicsBody, _ bodyB: SKPhysicsBody) {

        if (bodyA.node == nil || bodyB.node == nil) { return }
        
        // setup action message type
        switchActionMessageType(to: .PickUpItemAction)
        
        var gameItemContacted: SKPhysicsBody?
        
        if bodyA.node?.name != "playerNode" {
            gameItemContacted = bodyA
        } else if bodyB.node?.name != "playerNode" {
            gameItemContacted = bodyB
        }
        
        if let gameItem = gameItemContacted?.node?.userData?.value(forKeyPath: "self") as? GameItem {
            
            player?.currTargetItem = gameItem
            
            self.showActionMessage()
            self.showTargetWindow(with: gameItem)

        }

    }
}
