//
//  PigeonCollisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.12.2023.
//

import Foundation
import SpriteKit

// Pigeon's Collision Processing
extension ParkingWorkGame {
    func pigeonCollisionsProcess(for contactMask: UInt32, and contact: SKPhysicsContact) {
        switch contactMask {
        case (playerCategory | pigeonCategory):
            playerAndPigeonContact(contact.bodyA, contact.bodyB)
        case (carCategory | pigeonCategory):
            playerAndPigeonContact(contact.bodyA, contact.bodyB)
        default:
            return
        }
    }
    
    func playerAndPigeonContact(_ bodyA: SKPhysicsBody, _ bodyB: SKPhysicsBody ) {

        if (bodyA.node == nil || bodyB.node == nil) { return }

        var pigeonContacted: SKPhysicsBody?
        var position: CGPoint?

        if bodyA.node?.name?.split(separator: "_")[0] == "pigeon" {
            pigeonContacted = bodyA
        }
        if bodyB.node?.name?.split(separator: "_")[0] == "pigeon" {
            pigeonContacted = bodyB
        }

        position = pigeonContacted?.node?.position
        pigeonContacted?.node?.removeAllChildren()
        pigeonContacted?.node?.removeFromParent()
        
        let spritePigeonFly = SKSpriteNode(imageNamed: "pigeon_fly")
        spritePigeonFly.size = CGSize(width: 100, height: 80)
        spritePigeonFly.position = position!
        
        self.addChild(spritePigeonFly)
        
        let randPigeonPos = getRandomPointOutsideGameWorld()
    
        // rotate pigeon
        var flyRight = false
        var flyLeft = false
        var flyUp = false
        var flyDown = false
        
        if randPigeonPos.x > 0 {
            flyRight = true
        }
        
        if randPigeonPos.x < 0 {
            flyLeft = true
        }
        
        if randPigeonPos.y > 0 {
            flyUp = true
        }
        
        if randPigeonPos.y < 0 {
            flyDown = true
        }
    
        // set sprite face direction when fly by diagonal
        if flyLeft && flyDown {
            let action = SKAction.rotate(toAngle: 0.8449, duration: 0.3, shortestUnitArc: true)
            spritePigeonFly.run(action)
        } else if flyLeft && flyUp {
            let action = SKAction.rotate(toAngle: -0.8449, duration: 0.3, shortestUnitArc: true)
            spritePigeonFly.run(action)
        } else if flyRight && flyUp {
            let action = SKAction.rotate(toAngle: -2.24, duration: 0.3, shortestUnitArc: true)
            spritePigeonFly.run(action)
        } else if flyRight && flyDown {
            let action = SKAction.rotate(toAngle: 2.44, duration: 0.3, shortestUnitArc: true)
            spritePigeonFly.run(action)
        }
        
        if flyUp && !flyLeft && !flyRight && !flyDown {
            let action = SKAction.rotate(toAngle: 0.0449, duration: 0.1, shortestUnitArc: true)
            spritePigeonFly.run(action)
        } else if flyDown && !flyLeft && !flyRight && !flyUp {
            let action = SKAction.rotate(toAngle: 3.1449, duration: 0.1, shortestUnitArc: true)
            spritePigeonFly.run(action)
        } else if flyLeft && !flyUp && !flyDown && !flyRight {
            let action = SKAction.rotate(toAngle: 1.6449, duration: 0.1, shortestUnitArc: true)
            spritePigeonFly.run(action)
        } else if flyRight && !flyUp && !flyDown && !flyLeft {
            let action = SKAction.rotate(toAngle: 4.6449, duration: 0.1, shortestUnitArc: true)
            spritePigeonFly.run(action)
            
        }
        
        spritePigeonFly.run(SKAction.move(to: randPigeonPos, duration: 20))
    
        // play pigeon flying away sound if we have it
        if let pigeonSound = self.childNode(withName: "pigeon-flying-away") {
            pigeonSound.run(.play())
        }
    }
}
