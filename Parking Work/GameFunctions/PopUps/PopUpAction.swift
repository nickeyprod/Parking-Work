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
    
    /// Shows pop-up window, offering some action, when player comes сlose to some item.
    func showActionMessage() {
        if actionMessageWindow?.alpha != 0 || itemChoosingWindow?.alpha == 1 { return }
        let actionMessageLabel = actionMessageWindow?.childNode(withName: "ui-actionMessage") as? SKLabelNode
        
        if actionMessageType == .OpenCarAction {
            actionMessageLabel?.text = "Попробовать вскрыть?"
        } else if actionMessageType == .PickUpItemAction {
            actionMessageLabel?.text = "Подобрать вещь?"
        } else if actionMessageType == .DoorRingAction {
            actionMessageLabel?.text = "Позвонить в дверь?"
        } else if actionMessageType == .fireOldCopperWindow {
            actionMessageLabel?.text = "Бросить в окно бычок?"
        }
        
        actionMessageWindow?.alpha = 1
    }
    
    // Hides pop-up window, that offering some action.
    func hideActionMessage() {
        actionMessageWindow?.alpha = 0
        canGoFromDoor = false
    }
    
    // Shows player's target as a pop up at the top of the screen
    func showTargetWindow(with targetCar: Car, targetLock: CarLock) {
        
        // add one zero at the end if complexity 0.1 to display -> 0.10
        let complexity = "\(targetLock.complexity)".count == 3 ? "\(targetLock.complexity)0" : "\(targetLock.complexity)"
        
        let carNameLabel = self.targetWindow?.childNode(withName: "target-name") as? SKLabelNode
        let lockTypeLabel = self.targetWindow?.childNode(withName: "lockTypeLabel") as? SKLabelNode
        let complexityLabel = self.targetWindow?.childNode(withName: "complexity-label") as? SKLabelNode
        let complexityNum = complexityLabel?.childNode(withName: "complexityNumLevel") as? SKLabelNode
        
        carNameLabel?.text = "\(targetCar.name)"
        carNameLabel?.fontSize = 20
        
        lockTypeLabel?.text = "\(LOCK_TRANSLATIONS[targetLock.type] ?? "тип неизвестен")"
        complexityNum?.text = "\(complexity)"
        
        let chance = player!.unlockSkill / Float(complexity)!
        
        if complexityNum != nil {
            colorComplexity(chance: chance, complexityNum: complexityNum!)
        }
 
        self.targetWindow?.alpha = 0.8
        
        // if no complexity label, add it
        if self.targetWindow?.childNode(withName: "complexity-label") == nil {
            // target's car lock complexity
            // - lock type label
            let lockTypeLabel = SKLabelNode(text: "\(LOCK_TRANSLATIONS[targetLock.type] ?? "тип неизвестен")")
            lockTypeLabel.name = "lockTypeLabel"
            lockTypeLabel.fontName = "Hoefler Text"
            lockTypeLabel.fontSize = 18
            lockTypeLabel.fontColor = UIColor(named: COLORS.OpenCarWindowLockTypeColor.rawValue)
            lockTypeLabel.verticalAlignmentMode = .top
            lockTypeLabel.position = targetWindowLockTypeLabelPos!
            
            targetWindow?.addChild(lockTypeLabel)
            
            let complexityLabel = SKLabelNode(text: "Cложность:")
            complexityLabel.name = "complexity-label"
            complexityLabel.fontName = "Hoefler Text"
            complexityLabel.fontSize = 18
            complexityLabel.position = targetWindowComplexityLabelPos!
            complexityLabel.fontColor = UIColor(named: COLORS.OpenCarWindowComplexityColor.rawValue)
            complexityLabel.verticalAlignmentMode = .top
            
            targetWindow?.addChild(complexityLabel)
            
            // complexity level number
            let complexityNumLabel = SKLabelNode(text: complexity)
            complexityNumLabel.name = "complexityNumLevel"
            complexityNumLabel.fontName = "Hoefler Text"
            complexityNumLabel.fontSize = 18
            complexityNumLabel.position = CGPoint(x: 72, y: -3)
            complexityNumLabel.fontColor = UIColor(named: COLORS.OpenCarLockComplexityLightColor.rawValue)
            complexityNumLabel.verticalAlignmentMode = .top
            
            complexityLabel.addChild(complexityNumLabel)
            
            adjustSizeOfTargetWindow(to: targetWindowInitialHeight!)
            colorComplexity(chance: chance, complexityNum: complexityNumLabel)
            
        }
    }
    
    // Shows player's target as a pop up at the top of the screen
    func showTargetWindow(with gameItem: GameItem) {
        if targetWindow?.alpha == 1 { return }
    
        let itemNameLabel = self.targetWindow?.childNode(withName: "target-name") as? SKLabelNode
        itemNameLabel?.text = "\(gameItem.name)"
        itemNameLabel?.fontSize = 16
        
        targetWindow?.removeAllChildren()
        targetWindow?.addChild(itemNameLabel!)
        
        // change size of the target square to fit entrail's height
        let newHeight = self.getHeightOfAllNodesInTargetSquare() + 10
        self.adjustSizeOfTargetWindow(to: newHeight, width: (itemNameLabel?.frame.width)! + 20)
        
        targetWindow?.alpha = 1
    }
    
    // Shows player's target as a pop up at the top of the screen
    func showTargetWindow(with car: Car) {
        if targetWindow?.alpha == 1 { return }
    
        let itemNameLabel = self.targetWindow?.childNode(withName: "target-name") as? SKLabelNode
        itemNameLabel?.text = "\(car.name)"
        itemNameLabel?.fontSize = 16
        
        targetWindow?.removeAllChildren()
        targetWindow?.addChild(itemNameLabel!)
        
        // change size of the target square to fit entrail's height
        let newHeight = self.getHeightOfAllNodesInTargetSquare() + 10
        self.adjustSizeOfTargetWindow(to: newHeight, width: (itemNameLabel?.frame.width)! + 20)
        
        targetWindow?.alpha = 1
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
    func hideTargetWindow() {
        self.targetWindow?.alpha = 0
        
        // tries of open set to 0
        self.player?.triedToOpenComplexLockTimes = 0
        self.player?.triedToOpenComplexLockTimes = 0
    }
    
    func showChoosingItemWindow(numOfSquares: Int, with items: [GameItem]) {
        itemChoosingWindow?.setScale(0)
        
        createItemChoosingPanel(numSquares: numOfSquares, with: items)
        
        itemChoosingWindow?.alpha = 1
        itemChoosingWindow?.run(.scale(to: 1.15, duration: 0.3), completion: {
            self.itemChoosingWindow?.run(.scale(to: 1.0, duration: 0.15))
        })
        
    }
    
    func hideChoosingItemWindow() {
        itemChoosingWindow?.run(.scale(to: 0.0, duration: 0.2)) {
            self.itemChoosingWindow?.alpha = 0
        }
    }
}
