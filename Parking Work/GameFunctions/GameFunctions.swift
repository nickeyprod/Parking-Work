//
//  GamePlayFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// General Game Functions
extension ParkingWorkGame {
    
    /// Shows pop-up window, offering to try to open the lock when player comes сlose to it
    func showOpenCarMessage(of targetCar: TargetCar) {
        print(targetCar)
        
        let carNode = self.childNode(withName: targetCar.carName)
        let targetLock = carNode?.childNode(withName: targetCar.lockType)
        
        openCarWindow?.position = player!.position
        openCarWindowNameLabel?.text = "\(targetCar.carName)"
        
        if openCarWindow?.alpha == 0 {
            openCarWindow?.alpha = 1
        }

    }
}

