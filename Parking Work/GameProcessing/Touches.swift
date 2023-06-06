//
//  TouchesExtension.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Touches processing
extension ParkingWorkGame {

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch in touches {
            
            let location = touch.location(in: self)
            if startTouchPosition == nil {
                startTouchPosition = location
                
            }
            // buttons pressed check
            let touchedNode = atPoint(location)
            
            startTouchNode = touchedNode

            if (touchedNode.name == "ui-taskBtn" || touchedNode.name == "ui-taskLabel") && !isUILocked {
                showTaskScreen()
                run(MenuSounds.button_click.action)
            }
            else if (touchedNode.name == "ui-runBtn" || touchedNode.name == "ui-runBtnImg") && !isUILocked {
                isRunButtonHolded = true
                self.runButton?.run(.scale(to: 1.2, duration: 0))
                
            }
            else if (touchedNode.name == "ui-closeTaskBtn" || touchedNode.name == "ui-closeTaskLabel") && !isUILocked {
                hideTaskScreen()
                run(MenuSounds.button_click.action)
            }
            else if (touchedNode.name == "ui-menuBtn" || touchedNode.name == "ui-menuLabel") && !isUILocked {
                showMenuScreen()
                run(MenuSounds.button_click.action)
            }
            else if (touchedNode.name == "ui-resumeGameBtn" || touchedNode.name == "ui-resumeGameBtnLabel") && !isUILocked {
                hideMenuScreen()
                run(MenuSounds.button_click.action)
            }
            else if (touchedNode.name == "ui-gameSettingsBtn" || touchedNode.name == "ui-gameSettingsBtnLabel") && !isUILocked {
                showSettingsScreen()
                run(MenuSounds.button_click.action)
            }
            else if (touchedNode.name == "ui-actionYesBtn" || touchedNode.parent?.name == "ui-actionYesBtn") && !isUILocked {
                // off opening car when tutorial message is opened
                if !canMoveCamera { return }
                if actionMessageType == .OpenCarAction {
                    // try to open target door of the car
                    player!.tryOpenCarLock(of: player!.currTargetCar!, lockType: player!.currLockTarget!.name!)
                } else if actionMessageType == .PickUpItemAction {
                    player!.pickUpTargetItem()
                }
                
                run(MenuSounds.button_click.action)
            }
            else if touchedNode.name == "goodButton" || touchedNode.name == "goodLabel" {
                // hide open success message and play button click sound
                hideCarOpenedSuccessMessage()
                run(MenuSounds.button_click.action)
            } else if touchedNode.name == "ui-scroll-up-chat-btn" && !isUILocked {
                scrollChatUp()
            } else if touchedNode.name == "ui-scroll-down-chat-btn" && !isUILocked {
                scrollChatDown()
            } else if touchedNode.name == "ui-scroll-chat-slider" && !isUILocked {
                self.sliderTouchIsHolded = true
            }
            else if (touchedNode.name == "ui-driveBtn" || touchedNode.name == "ui-driveBtnImg") && !isUILocked {
                self.driveBtnHolded = true
                self.runButton?.run(.scale(to: 1.1, duration: 0))
            }
            else if (touchedNode.name == "ui-brakeBtn" || touchedNode.name == "ui-brakeBtnImg") && !isUILocked {
                self.brakeBtnHolded = true
                self.brakeButton?.run(.scale(to: 1.1, duration: 0))
            }
            else if touchedNode.name == "ui-arrow-left" && !isUILocked {
                self.leftArrowHolded = true
                self.leftButton?.run(.scale(to: 1.1, duration: 0))
            }
            else if touchedNode.name == "ui-arrow-right" && !isUILocked {
                self.rightArrowHolded = true
                self.rightButton?.run(.scale(to: 1.1, duration: 0))
            }
            else if touchedNode.name == "ui-exit-car-btn" && !isUILocked {
                self.player?.getOutOfCar()
                self.exitFromCarBtn?.run(.scale(to: 1.1, duration: 0))
                run(MenuSounds.button_click.action)
            }
            else if touchedNode.name == "ui-enter-car-btn" && !isUILocked {
                self.player?.getIn(the: player!.currTargetCar!)
                run(MenuSounds.button_click.action)
            }
            else if (touchedNode.name == "ui-inventory-btn") && !isUILocked {
                self.inventoryButton?.run(.scale(to: 1.2, duration: 0))
                run(InventorySounds.bag_open.action)
                if !isInventoryOpened {
                    openInventory()
                } else {
                    closeInventory()
                }
            }
            else if (touchedNode.name == "ui-closeInventoryBtn" || touchedNode.parent?.name == "ui-closeInventoryBtn") && !isUILocked {
                run(InventorySounds.bag_open.action)
                if isInventoryOpened {
                    closeInventory()
                }
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
        
        for touch in touches {
            
            let touchLocation = touch.location(in: self)
            let touchedNode = atPoint(touchLocation)
              
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

        var isTouchingUI = false
        if touchedNode.name?.split(separator: "-")[0] == "ui" || startTouchNode?.name?.split(separator: "-")[0] == "ui" {
            isTouchingUI = true
        }
        return isTouchingUI
    }

}

