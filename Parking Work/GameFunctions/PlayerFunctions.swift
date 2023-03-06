//
//  PlayerFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Player Abilities
extension ParkingWorkGame {
    
    // MARK: - Car Locks Opening Logic
    /// Player can try to open any lock of any car on the map
    func tryOpenCarLock(of car: Car, lockType: String) {
        print(car.name, car.locks[lockType])
        
        // 100% - 0.08% = 99,92%
        let percentOfSuccess = 1.0 - car.locks[lockType]!! /// 1.0 - 0.08 = 0.92
        let randomInt = Float.random(in: 0.0...1.0) // 0.82

        if (randomInt <= percentOfSuccess)  {
            // add it to owned cars array
            ownedCars.append(car)
            // remove the car from tilemap
            car.node?.removeFromParent()
            // play door open sound
            run(Sound.door_open.action)
            // hide open car window pop-up
            hideOpenCarMessage()
            // play success ring
            run(Sound.success_bell.action)
            // show car successfuly opened message
            showCarOpenedSuccessMessage(of: car)
            
        } else {
            print("The door open has failed")
            // play door closed sound & car signalization sound
            run(Sound.car_door_locked.action)
            run(Sound.car_signalization.action, withKey: car.name + "_light_signal")
            
            // hide open car message
            hideOpenCarMessage()
            
            // block lock of the car
//            cars[car.carName].
            
            // blick lights
            blinkLightSignals(of: car)
            car.signaling = true
        }

    }
    
}
