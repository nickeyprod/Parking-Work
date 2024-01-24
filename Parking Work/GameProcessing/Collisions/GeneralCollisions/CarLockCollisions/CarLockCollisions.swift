//
//  CarLockCollisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.12.2023.
//

import Foundation
import SpriteKit

extension ParkingWorkGame {
    func carLockCollisionsProcess(for contactMask: UInt32, and contact: SKPhysicsContact) {
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
        default:
            player!.currTargetLock = nil
        }
    }
    
    // performs action on player and car lock contact
    func playerAndLockContact(_ bodyA: SKPhysicsBody,  _ bodyB: SKPhysicsBody) {

        if bodyA.node!.name != "playerNode" {
            player?.currTargetLock = bodyA.node!.userData?.value(forKey: "self") as? CarLock
        }
        if bodyB.node!.name != "playerNode" {
            player?.currTargetLock = bodyB.node!.userData?.value(forKey: "self") as? CarLock
        }
        
        // setup action message type
        switchActionMessageType(to: .OpenCarAction)
    
        // initialize Car object
        player!.currTargetCar = player?.currTargetLock?.node .parent?.userData?.value(forKey: "self") as? Car
        
        if player?.currTargetCar?.stolen == true {
            // if no enter to car button -> show it
            if  self.enterToCarBtn == nil {
                
                self.showTargetWindow(with: player!.currTargetCar!, targetLock: player!.currTargetLock!)
                
                // show enter to car button
                let enterButton = SKSpriteNode(texture: SKTexture(imageNamed: "car-door"))
                enterButton.size.width = 56
                enterButton.size.height = 56
                enterButton.position = CGPoint(x: (displayWidth! / 2) - 40, y: -(displayHeight! / 2) + 180)
                enterButton.zPosition = 25
                enterButton.userData = NSMutableDictionary()
                enterButton.userData?.setValue(GameButtons.EnterCarButton, forKey: "btn-type")
                
                self.enterToCarBtn = enterButton
                self.cameraNode?.addChild(enterButton)
                
            }
            
        } else {
            // show message suggesting to open target car
            let playerPosition = player!.node!.position
            let targetCarPosition = player!.currTargetCar!.node?.position

            let diffX = abs(playerPosition.x) - abs(targetCarPosition!.x)
            let diffY = abs(playerPosition.y) - abs(targetCarPosition!.y)
            
            // if distance not more than 150 and car is not signaling
            if (abs(diffX) < 150 && abs(diffY) < 150 && !player!.currTargetCar!.signaling) && !player!.isSittingInCar {
                self.showActionMessage()
                
                // showing target
                self.showTargetWindow(with: player!.currTargetCar!, targetLock: player!.currTargetLock!)
            }
        }
        
    }
    
}
