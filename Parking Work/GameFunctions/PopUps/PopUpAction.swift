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
        self.isUILocked = true
        
        let carName = targetCar.name
        
//        let lockType = (player?.currLockTarget?.name)!
//        let lockName = "\(LOCK_TRANSLATIONS[lockType] ?? "тип неизвестен")"
        
        openCarSuccessWindow?.position = CGPoint(x: 0, y: 0)
        openCarSuccessWindowGarageLabel?.text = "Вы успешно вкрыли \(carName)."
        openCarSuccessWindowGarageLabel?.preferredMaxLayoutWidth = (openCarSuccessWindow?.frame.width)! - 40
        openCarSuccessWindowGarageLabel?.numberOfLines = 0
        
        openCarSuccessWindow?.alpha = 1
        
    }
    
    // Hide message about successful car's lock open
    func hideCarOpenedSuccessMessage() {
        self.isUILocked = false
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
        
        if complexityNum != nil {
            colorComplexity(chance: chance, complexityNum: complexityNum!)
        }
 
        self.targetSquare?.alpha = 0.8
        
        // if no complexity label, add it
        if self.targetSquare?.childNode(withName: "complexity-label") == nil {
            // target's car lock complexity
            // - lock type label
            let lockTypeLabel = SKLabelNode(text: "\(LOCK_TRANSLATIONS[lockType] ?? "тип неизвестен")")
            lockTypeLabel.name = "lockTypeLabel"
            lockTypeLabel.fontName = "Hoefler Text"
            lockTypeLabel.fontSize = 18
            lockTypeLabel.fontColor = UIColor(named: COLORS.OpenCarWindowLockTypeColor.rawValue)
            lockTypeLabel.verticalAlignmentMode = .top
            lockTypeLabel.position = targetSquareLockTypeLabelPos!
            
            targetSquare?.addChild(lockTypeLabel)
            
            let complexityLabel = SKLabelNode(text: "Cложность:")
            complexityLabel.name = "complexity-label"
            complexityLabel.fontName = "Hoefler Text"
            complexityLabel.fontSize = 18
            complexityLabel.position = targetSquareComplexityLabelPos!
            complexityLabel.fontColor = UIColor(named: COLORS.OpenCarWindowComplexityColor.rawValue)
            complexityLabel.verticalAlignmentMode = .top
            
            targetSquare?.addChild(complexityLabel)
            
            // complexity level number
            let complexityNumLabel = SKLabelNode(text: complexity)
            complexityNumLabel.name = "complexityNumLevel"
            complexityNumLabel.fontName = "Hoefler Text"
            complexityNumLabel.fontSize = 18
            complexityNumLabel.position = CGPoint(x: 72, y: -3)
            complexityNumLabel.fontColor = UIColor(named: COLORS.OpenCarLockComplexityLightColor.rawValue)
            complexityNumLabel.verticalAlignmentMode = .top
            
            complexityLabel.addChild(complexityNumLabel)
            
            adjustSizeOfTargetSquare(to: targetSquareInitialHeight!)
            colorComplexity(chance: chance, complexityNum: complexityNumLabel)
            
        }
    }
    
    func colorComplexity(chance: Float, complexityNum: SKLabelNode) {
        if chance < 1.0 {
            complexityNum.fontColor = UIColor(named: COLORS.OpenCarLockComplexityHardColor.rawValue)
        }
        else if chance >= 1.0 && chance <= 2.0 {
            complexityNum.fontColor = UIColor(named: COLORS.OpenCarLockComplexityMiddleColor.rawValue)
        } else if chance >= 2.0 {
            complexityNum.fontColor = UIColor(named:  COLORS.OpenCarLockComplexityLightColor.rawValue)
        }
    }
    
    // Hides players' current target pop up, when target cancels
    func hideTargetSquare() {
        self.targetSquare?.alpha = 0
        
        // tries of open set to 0
        self.player?.triedToOpenComplexLockTimes = 0
        self.player?.triedToOpenComplexLockTimes = 0
    }
}
