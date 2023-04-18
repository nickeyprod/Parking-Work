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
    
//        print("didBeginContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
        
        let contactMask = getContactMask(contact.bodyA, contact.bodyB)

        switch contactMask {
        case (playerCategory | lockCategory):
            
            // debounce rotation when player comes to lock, so player not rotating when stopped
            canRotate = false
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                self.canRotate = true
            }
            playerAndLockContact(contact.bodyA, contact.bodyB)
            
            // show tutorial on car locks if first opened
            if firstCarOpened == false {
                self.firstCarOpened = true
                showCarLocksTutorial(tutorialMsg: 25)
            }

        case (playerCategory | firstCircleCategory):
            playerInFirstCircle = true
            playerInCircleOfCar = contact.bodyB.node?.parent
            raiseAnxiety(to: 1)
        case (playerCategory | secondCircleCategory):
            playerInSecondCircle = true
            playerInCircleOfCar = contact.bodyB.node?.parent
            raiseAnxiety(to: 0.5)
        case (playerCategory | thirdCircleCategory):
            playerInThirdCircle = true
            playerInCircleOfCar = contact.bodyB.node?.parent
            raiseAnxiety(to: 0.3)
        case (playerCategory | pigeonCategory):
            playerAndPigeonContact(contact.bodyA, contact.bodyB)
            
        default:
            player!.currLockTarget = nil
//            print("Some other contact occurred")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        let contactMask = getContactMask(contact.bodyA, contact.bodyB)
        
//        print("didEndContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
        
        switch contactMask {
        case (playerCategory | firstCircleCategory):
            playerInFirstCircle = false
            reduceAnxiety(to: 1)
        case (playerCategory | secondCircleCategory):
            playerInSecondCircle = false
            reduceAnxiety(to: 0.5)
        case (playerCategory | thirdCircleCategory):
            playerInThirdCircle = false
            reduceAnxiety(to: 0.3)
        default:
            break
//            print("Some other contact ended")
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
    }
    
    // just returns contact mask
    func getContactMask(_ bodyA: SKPhysicsBody, _ bodyB: SKPhysicsBody) -> UInt32 { (bodyA.categoryBitMask | bodyB.categoryBitMask) }
    
    // performs action on player and car lock contact
    func playerAndLockContact(_ bodyA: SKPhysicsBody,  _ bodyB: SKPhysicsBody) {

        if bodyA.node!.name != "playerNode" {
            player?.currLockTarget = bodyA.node
        }
        if bodyB.node!.name != "playerNode" {
            player?.currLockTarget = bodyB.node
        }
        
        // get lock type
        let lockType = player?.currLockTarget?.name
        
        // initialize Car object
        player!.currTargetCar = player?.currLockTarget?.parent?.userData?.value(forKey: "self") as? Car

        // show message suggesting to open the target car
        let playerPosition = player!.node!.position
        let targetLockPosition = player!.currLockTarget?.parent?.position

        let diffX = abs(playerPosition.x) - abs(targetLockPosition!.x)
        let diffY = abs(playerPosition.y) - abs(targetLockPosition!.y)
        
        // if distance not more than 150 and car is not signaling
        if (abs(diffX) < 150 && abs(diffY) < 150 && !player!.currTargetCar!.signaling) {
            self.showOpenCarMessage(of: player!.currTargetCar!, lockType: lockType!)
            // showing target
            self.showTargetSquare(of: player!.currTargetCar!, lockType: lockType!)
        }
    }
}
