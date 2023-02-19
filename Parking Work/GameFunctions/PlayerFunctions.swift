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
    func tryOpenCarLock(of car: TargetCar) {
        
        // 100% - 0.08% = 99,92%
        let percentOfSuccess = 100.0 - car.lockComplexity
        
        let randomInt = Float.random(in: 0.0...100.0)
        print(randomInt)
        if (percentOfSuccess >= randomInt) && (randomInt <= 100.0) {
            print("The \(LOCK_TRANSLATIONS[car.lockType]!) door of \(car.carName) has been opened!")
            
            // init owned car object
            let ownedCar = OwnedCar(carName: car.carName, lockType: car.lockType, lockComplexity: car.lockComplexity, stolen: true)
            // add it to owned cars array
            ownedCars.append(ownedCar)
            // remove the car from tilemap
            self.childNode(withName: car.carName)?.removeFromParent()
            // play door open sound
            run(Sound.door_open.action)
            // hide open car window pop-up
            hideOpenCarMessage()
            // play success ring
            run(Sound.success_bell.action)
            
        } else {
            print("The door open has failed")
            // play door closed sound & car signalization sound
            run(Sound.car_door_locked.action)
            run(Sound.car_signalization.action)
        }

    }
    
}

