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
