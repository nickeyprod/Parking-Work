//
//  TouchesExtension.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Touches processing
extension ParkingWorkGame {
    
    func processUserTouches(touchedNode: SKNode) {

        // Process User Interface Buttons Presses
        processUIButtonPresses(touchedNode: touchedNode)
        
        // Process Game Chat User Button Presses
        processGameChatPresses(touchedNode: touchedNode)
        
        // Process User Action Button Presses
        processActionButtonPresses(touchedNode: touchedNode)
        
        // Process Car Driving Button Presses
        processCarDriveButtonPresses(touchedNode: touchedNode)
        
        // Process Inventory Touches
        processInventoryTouches(touchedNode: touchedNode)
        
        // Process Fast Access Panel Touches
        processFastAccessPanelTouches(touchedNode: touchedNode)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            
            let location = touch.location(in: self)
            if startTouchPosition == nil {
                startTouchPosition = location
            }
            
            // Find which node on a screen was touched
            let touchedNode = atPoint(location)
            
            // Set start touch node
            startTouchNode = touchedNode
            
            if !isUILocked {
                // Process User UI Touches only if it it's not locked
                processUserTouches(touchedNode: touchedNode)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        if event?.allTouches?.count == 2 || self.isPaused || !canMoveCamera  { return }
        if isRunButtonHolded { return }
        
        cameraMovingByFinger = true
        
        for touch in touches {
            let location = touch.location(in: self)
            
            currTouchPosition = CGPoint(x: location.x, y: location.y)
            
            // for chat slider moving
            let movingSliderUp = prevTouchPos!.y < currTouchPosition!.y
            let movingSliderDown = prevTouchPos!.y > currTouchPosition!.y
            
            // for slider movement
            prevTouchPos = currTouchPosition
            
            // chat slider moving logic
            if sliderTouchIsHolded {
                if movingSliderUp && (self.chatSlider?.position.y)! < self.chatSliderTopPos!.y {
                    self.scrollChatUp()
                } else if movingSliderDown && (self.chatSlider?.position.y)! > self.chatSliderBottomPos!.y {
                    self.scrollChatDown()
                }
            }
            
            // movig camera logic
            if !sliderTouchIsHolded && currTouchPosition != nil && startTouchPosition != nil {
                
                let diffX = startTouchPosition!.x - currTouchPosition!.x
                let diffY = startTouchPosition!.y - currTouchPosition!.y
                
                // restrict camera movement by X to top and right world bounds
                if (rightTopCameraEnd!.x <= rightTopEnd!.x) && (leftBottomCameraEnd!.x >= leftBottomEnd!.x) {
                    cameraNode?.position.x = (cameraNode?.position.x)! + diffX
                } else {
                    let newPosX = (cameraNode?.position.x)! + diffX
                    if (newPosX <= rightTopEnd!.x) && (newPosX >= leftBottomEnd!.x) {
                        cameraNode?.position.x = newPosX
                    } else {
                        if (cameraNode?.position.x)! < 0 {
                            cameraNode?.position.x = leftBottomEnd!.x
                        } else {
                            cameraNode?.position.x = rightTopEnd!.x
                        }
                        
                    }
                }
                
                // restrict camera movement by Y to bottom and left world bounds
                if (rightTopCameraEnd!.y <= rightTopEnd!.y) && (leftBottomCameraEnd!.y >= leftBottomEnd!.y) {
                    cameraNode?.position.y = (cameraNode?.position.y)! + diffY
                } else {

                    let newPosY = (cameraNode?.position.y)! + diffY

                    if newPosY <= rightTopEnd!.y && newPosY >= leftBottomEnd!.y {
                        cameraNode?.position.y = newPosY
                    } else {
                        if (cameraNode?.position.y)! < 0 {
                            cameraNode?.position.y = leftBottomEnd!.y
                        } else {
                            cameraNode?.position.y = rightTopEnd!.y
                        }
                        
                    }
                }

            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
 
        
        // need to turn off specific buttons! for driving! not all!
        self.sliderTouchIsHolded = false
        
        // off run
        isRunButtonHolded = false
        self.runButton?.run(.scale(to: 1.0, duration: 0))
        
        // off drive
        self.driveBtnHolded = false
        self.runButton?.run(.scale(to: 1.0, duration: 0))
        
        // off brake
        self.brakeBtnHolded = false
        self.brakeButton?.run(.scale(to: 1.0, duration: 0))
        
        startTouchPosition = nil
        
        if isUILocked { return }
        
        for touch in touches {
            
            let touchLocation = touch.location(in: self)
            let touchedNode = atPoint(touchLocation)
            
            if touchedNode.name?.split(separator: "-")[0] == "inventory" { return }

            if !player!.isSittingInCar && cameraMovingByFinger == false && !isTouchingUI(touchedNode: touchedNode) && !self.isPaused && !cameraZooming && isRunButtonHolded == false && tutorialEnded == true && canMoveCamera == true {

                player?.destinationPosition = touchLocation
                targetCircleSprite?.removeFromParent()
                setTarget(at: touchLocation)
            }
            if touchedNode.name == "ui-runBtn" || touchedNode.name == "ui-runBtnImg" {
//                isRunButtonHolded = false
//                self.runButton?.run(.scale(to: 1.0, duration: 0))
                
            } else if touchedNode.name == "ui-driveBtn" || touchedNode.name == "ui-driveBtnImg" {
                self.driveBtnHolded = false
                self.runButton?.run(.scale(to: 1.0, duration: 0))
            }
            else if touchedNode.name == "ui-brakeBtn" || touchedNode.name == "ui-brakeBtnImg" {
                self.brakeBtnHolded = false
                self.brakeButton?.run(.scale(to: 1.0, duration: 0))
            }
            else if touchedNode.name == "ui-arrow-left" {
                self.leftArrowHolded = false
                self.leftButton?.run(.scale(to: 1.0, duration: 0))
            }
            else if touchedNode.name == "ui-arrow-right" {
                self.rightArrowHolded = false
                self.rightButton?.run(.scale(to: 1.0, duration: 0))
            }
            else if touchedNode.name == "ui-exit-car-btn" {
                self.exitFromCarBtn?.run(.scale(to: 1.0, duration: 0))
            }
            else if (touchedNode.name == "ui-inventory-btn") {
                self.inventoryButton?.run(.scale(to: 1.0, duration: 0))
            }
            
            cameraMovingByFinger = false
            startTouchNode = nil
            
        }
    }
    
    func setTarget(at location: CGPoint) {
        // setting 'target' sprite on ground
        targetCircleSprite = SKSpriteNode(imageNamed: "target")
        targetCircleSprite!.position = location
        targetCircleSprite!.xScale = 0.2
        targetCircleSprite!.yScale = 0.2
        targetCircleSprite?.zPosition = 1
        targetCircleSprite?.colorBlendFactor = 0.4
        addChild(targetCircleSprite!)
        
        targetRotate(target: targetCircleSprite!)
    }
    
    func targetRotate(target: SKSpriteNode) {
        var angle = 1.14
        var rotatingAction = SKAction.rotate(byAngle: angle, duration: 1.0)
        target.run(rotatingAction)
        
        targetMovementTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            angle = -angle
            rotatingAction = SKAction.rotate(byAngle: angle, duration: 1.0)
            target.removeAllActions()
            target.run(rotatingAction)
        }
    }
    
    func isTouchingUI(touchedNode: SKNode) -> Bool {

        if touchedNode.buttonType == .notAButton {
            return false
        } else {
            return true
        }
      
    }

}

