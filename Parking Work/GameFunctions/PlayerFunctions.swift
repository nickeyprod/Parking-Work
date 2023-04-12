//
//  PlayerFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Player Abilities
extension Player {
    
    // MARK: - Car Locks Opening Logic
    /// Player can try to open any lock of any car on the map
    func tryOpenCarLock(of car: Car, lockType: String) {

//        let unlockSkill = 10
        
        // 100% - 0.08% = 99,92%
        let percentOfSuccess = 1.0 - car.locks[lockType]!! /// 1.0 - 0.08 = 0.92
        let randomInt = Float.random(in: 0.0...1.0) // 0.82
    

        if (randomInt <= percentOfSuccess)  {
 
            // add it to owned cars array
            ownedCars.append(car)
            // remove the car from tilemap
            car.node?.removeFromParent()
            // remove the car from minimap also
            car.miniMapDot?.removeFromParent()
            // play door open sound
            node?.run(Sound.door_open.action)
            
            // hide open car window pop-up
            scene.hideOpenCarMessage()
            // play success ring
            node?.run(Sound.success_bell.action)
            // show car successfuly opened message
            scene.showCarOpenedSuccessMessage(of: car)
            // raise anxiety
            scene.raiseAnxiety(to: 20.0)
            
        } else {
            print("The door open has failed")
            // raise anxiety!
            scene.raiseAnxiety(to: 80.0)
            
            let signal = Sound.car_signalization.audio
            let locked = Sound.car_door_locked.audio
            
            // play door closed sound & car signalization sound
            node?.parent?.addChild(locked)
            node?.parent?.addChild(signal)
            
            locked.run(SKAction.play())
            signal.run(SKAction.play())
            
            // hide open car message
            scene.hideOpenCarMessage()
            
            // blick lights
            scene.blinkLightSignals(of: car)
            car.signaling = true
            
            
        }

    }
    
    
    
}
