//
//  GamePlayFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// General Game Functions
extension ParkingWorkGame {
    
    /// Shows pop-up window, offering to try to open the lock when player comes сlose to it.
    func showOpenCarMessage(of targetCar: TargetCar) {
        
        // add one zero at the end if complexity 0.1 to display -> 0.10
        let complexity = "\(targetCar.lockComplexity)".count == 3 ? "\(targetCar.lockComplexity)0" : "\(targetCar.lockComplexity)"

        openCarWindow?.position = player!.position
        openCarWindowNameLabel?.text = "\(targetCar.carName)"
        openCarWindowLockTypeLabel?.text = "\(LOCK_TRANSLATIONS[targetCar.lockType] ?? "тип неизвестен")"
        openCarWindowComplexityNum?.text = "\(complexity)/1.00"
        
        openCarWindow?.alpha = 1
        
        // stop player movement
        // enter to initial player state
//        playerLocationDestination = player?.position
//        playerStateMachine.enter(IdleState.self)

    }
    
    /// Hides pop-up window, that offering to open car lock.
    func hideOpenCarMessage() {
        openCarWindow?.alpha = 0
    }
    
    func checkDistanceBetweenPlayerAndTargetLock() {
 
        let playerPosition = player?.position
        let targetLockPosition = currLockTarget?.parent?.position

        let diffX = abs(playerPosition!.x) - abs(targetLockPosition!.x)
        let diffY = abs(playerPosition!.y) - abs(targetLockPosition!.y)
        if (abs(diffX) > 120 || abs(diffY) > 120) {
            hideOpenCarMessage()
            currLockTarget = nil
        }
    }
    
    
}

