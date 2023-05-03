//
//  PopUpAction.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//


import SpriteKit

// Pop Up Action Game Functions
extension ParkingWorkGame {
    
    // Show message after successful car's lock open
    func showCarOpenedSuccessMessage(of targetCar: Car) {
        let carName = targetCar.name
        
        openCarSuccessWindow?.position = CGPoint(x: (cameraNode?.frame.midX)!, y: (cameraNode?.frame.midY)!)
        openCarSuccessWindowGarageLabel?.text = "\(carName) появится в вашем гараже"
        openCarSuccessWindow?.alpha = 1
        
    }
    
    // Hide message about successful car's lock open
    func hideCarOpenedSuccessMessage() {
        if openCarSuccessWindow?.alpha == 0 { return }
        openCarSuccessWindow?.alpha = 0
    }
    
    /// Shows pop-up window, offering to try to open the lock when player comes сlose to it.
    func showOpenCarMessage(of targetCar: Car, lockType: String) {
        if openCarWindow?.alpha != 0 { return }
        openCarWindow?.alpha = 1
    }
    
    // Hides pop-up window, that offering to open car lock.
    func hideOpenCarMessage() {
        openCarWindow?.alpha = 0
        canGoFromDoor = false
    }
    
    // Shows player's target car as a pop up at the top of the screen
    func showTargetSquare(of targetCar: Car, lockType: String) {
        
        // add one zero at the end if complexity 0.1 to display -> 0.10
        let complexity = "\(targetCar.locks[lockType]!!)".count == 3 ? "\(targetCar.locks[lockType]!!)0" : "\(targetCar.locks[lockType]!!)"
        
        let carNameLabel = self.targetSquare?.childNode(withName: "car-name") as? SKLabelNode
        let lockTypeLabel = self.targetSquare?.childNode(withName: "lockTypeLabel") as? SKLabelNode
        let complexityLabel = self.targetSquare?.childNode(withName: "complexity-label") as? SKLabelNode
        let complexityNum = complexityLabel?.childNode(withName: "complexityNumLevel") as? SKLabelNode
        
        carNameLabel?.text = "\(targetCar.name)"
        
        
        lockTypeLabel?.text = "\(LOCK_TRANSLATIONS[lockType] ?? "тип неизвестен")"
        complexityNum?.text = "\(complexity)"
        
        let chance = player!.unlockSkill / Float(complexity)!
        
        if chance < 1.0 {
            complexityNum?.fontColor = UIColor(named: Colors.OpenCarLockComplexityHardColor.rawValue)
        }
        else if chance >= 1.0 && chance <= 2.0 {
            complexityNum?.fontColor = UIColor(named: Colors.OpenCarLockComplexityMiddleColor.rawValue)
        } else if chance >= 2.0 {
            complexityNum?.fontColor = UIColor(named:  Colors.OpenCarLockComplexityLightColor.rawValue)
        }
        
        self.targetSquare?.alpha = 0.8
    }
    
    // Hides players' current target pop up, when target cancels
    func hideTargetSquare() {
        self.targetSquare?.alpha = 0
        
        // tries of open set to 0
        self.player?.triedToOpenComplexLockTimes = 0
        self.player?.triedToOpenComplexLockTimes = 0
    }
}
