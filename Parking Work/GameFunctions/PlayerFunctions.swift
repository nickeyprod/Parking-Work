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
    func tryOpenCarLock(of carName: String, lockType: String) {
        let lockComplexity = CAR_LIST[carName]?[lockType]!
        
        let targetCar = TargetCar(carName: carName, lockType: lockType, lockComplexity: lockComplexity!)
        
        // show message suggesting to open the target car
        self.showOpenCarMessage(of: targetCar)
        
    }
}

