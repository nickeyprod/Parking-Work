//
//  PlayerFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Player Abilities
extension Player {
    
    // MARK: - Car Locks Opening Logic
    /// Player can try to open any lock of any car on the map
    func tryOpenCarLock(of car: Car, lockType: String) {
        
        // check if player is opening jammed lock
        if playerIsOpeningJammedLock(car: car, lockType: lockType) {
            // push message to chat that lock is jammed
            return self.scene.pushMessageToChat(text: "Этот замок заклинило!")
        }
    
        // get lock complexity and chance to open
        let complexity = car.locks[lockType]!!
        let chance = scene.player!.unlockSkill / complexity
        
        print("chance ", chance)
        
        // if chance to open bigger than 1, player can try to open
        if chance >= 1 {
    
            // get probability of the lock to jam (can be from 10% to 20%)
            let wedgeProbability = Float(Int.random(in: 10...20)) - chance
            print("wedge probability: ", wedgeProbability)
            
            // gen random num between 10 and 100
            let randomWedgeNum = Float.random(in: 10.0...100.0)
            
            // lock jammed if randomWedgeNum in wedgeProbability range
            // if lock jammed, exit
            if randomWedgeNum <= wedgeProbability  {
                // run car lock has jammed steps, and return
                return openCarLockJammed(car: car, lockType: lockType)
            }
            
            // if lock is not jammed,
            // calculate percent of successful opening
            let percentOfSuccess = 100.0 - complexity
            let randomInt = Float.random(in: 0.0...100.0)
            
            // if randomInt is less than percentOfSuccess, lock opening
            if (randomInt <= percentOfSuccess)  {
                // calculate the level of noise it reproduce,
                // then add it to anxiety level
                calculateLevelOfNoise(with: chance)
                
                // car successfully opened steps
                successfullyOpenedCar(car: car, lockType: lockType)
            } else {
                // else lock open failing steps
                openCarFailed(car: car, lockType: lockType)
            }
            
        // this else runs if chance of open lock is less than 1,
        // it means player doesn't have enough skills to open it now
        } else {
            // message that player doesn't have enough skill for this lock
            scene.pushMessageToChat(text: "Невозможно открыть этот замок, не хватает умений.")
            
            // add tries if player trying to open the same lock again and again
            tryingOpenLock(car: car, type: "complex")

        }

    }
    
    // returns true if player is trying to open jammed lock
    func playerIsOpeningJammedLock(car: Car, lockType: String) -> Bool {
        if car.jammedLocks.count > 0 {
            for jammedLock in car.jammedLocks {
                if lockType == jammedLock {
                    // add num of tries when opening the same lock again and again
                    tryingOpenLock(car: car, type: "jammed")
                    return true
                }
            }
            return false
        }
        return false
    }
    
    func openCarLockJammed(car: Car, lockType: String) {
        // add the jammed lock to list of jammed locks of the car
        car.jammedLocks.append(lockType)
        
        // when lock is jammed,
        // 50% probability, that car start signaling
        if Int.random(in: 0...1) == 1 {
            
            // hide open car message
            scene.hideActionMessage()
            
            // play door closed sound if found it
            if let doorLockedSound = car.node?.childNode(withName: Sound.car_door_locked.rawValue) {
                doorLockedSound.run(.play())
            }
            
            // turn on signalization
            turnSignalizationOn(of: car)
    
            // raise anxiety!
            return scene.raiseAnxiety(to: 45.0)
        }
        
        // just raise anxiety if not jammed
        scene.raiseAnxiety(to: 20.0)
    }
    
    // this calculates level of noise and adds it to anxiety level
    func calculateLevelOfNoise(with chance: Float) {
        let minLevelNoise: Float = 20
        let maxLevelNoise: Float = 70
        
        var levelOfNoise = (maxLevelNoise / chance) - minLevelNoise
        
        if (levelOfNoise <= 0) {
            levelOfNoise = 0
        }
        
        print("Noise level:", levelOfNoise)
        
        scene.raiseAnxiety(to: CGFloat(levelOfNoise))
    }
    
    // run this function when open lock fails
    func openCarFailed(car: Car, lockType: String) {
        // push message that open has failed
        self.scene.pushMessageToChat(text: "Попытка вскрытия провалилась.")
        
        // raise anxiety!
        scene.raiseAnxiety(to: 80.0)
        
        // play door closed sound if found it
        if let doorLockedSound = car.node?.childNode(withName: Sound.car_door_locked.rawValue) {
            doorLockedSound.run(.play())
        }
        
        // turn signalization on!
        turnSignalizationOn(of: car)
        
        // hide open car message
        scene.hideActionMessage()
    }
    
    // run this function when open lock successes
    func successfullyOpenedCar(car: Car, lockType: String) {
        // add it to owned cars array
//        ownedCars.append(car)
        
        // remove the car from tilemap
//        removeCarFromTileMap(car: car)
        
        // hide target square
//        self.scene.hideTargetSquare()
        
        // hide open car window pop-up
        scene.hideActionMessage()
        
        // show car successfuly opened message
        scene.showCarOpenedSuccessMessage(of: car)
        
        // push message to chat that open was successful
        self.scene.pushMessageToChat(text: "\(car.name) - \(LOCK_TRANSLATIONS[lockType] ?? "Тип неизвестен") - вскрытие удалось!")
        self.scene.pushMessageToChat(text: "Машина появится в вашем гараже")
        
        // get in the car
        self.scene.player?.getIn(the: car)
    }

    // removing car node from game and from minimap,
    // also removing its anxiety circles.
    func removeCarFromTileMap(car: Car) {
        // remove car itself and its anxiety circles
        car.node?.removeFromParent()
        
        // remove the car from minimap also
        car.miniMapDot?.removeFromParent()
        
        // player is not in car's anxiety circles any more
        scene.playerInFirstCircle = false
        scene.playerInSecondCircle = false
        scene.playerInThirdCircle = false
    }
    
    // add number of tries for opening locks, that player cannot open
    // if player trying to open again and again, raise anxiety,
    // or turn on signalization if player is continuing his opening tries
    func tryingOpenLock(car: Car, type: String) {
        
        var numOfTries: Int?
        
        if type == "jammed" {
            self.triedToOpenJammedLockTimes += 1
            numOfTries = self.triedToOpenJammedLockTimes
        } else if type == "complex" {
            self.triedToOpenComplexLockTimes += 1
            numOfTries = self.triedToOpenComplexLockTimes
        }
        
        if numOfTries == 1 {
            scene.raiseAnxiety(to: 5)
        } else if (numOfTries == 2) {
            scene.raiseAnxiety(to: 6)
        } else if (numOfTries! > 3) {
            // if signal is not turned on -> warn player about it
            scene.pushMessageToChat(text: "Сигнализация может сработать...")
            // raise anxiety
            scene.raiseAnxiety(to: 10)
            
            // can be 0 or 1. If it will be 0 -> turn on signalization
            let chanceOfSignal = Int.random(in: 0...1)
            
            // 50% that on the next try, signalization turns on
            if chanceOfSignal == 0 {
                // hide open car message
                scene.hideActionMessage()
                
                // play door closed sound if found it
                if let doorLockedSound = car.node?.childNode(withName: Sound.car_door_locked.rawValue) {
                    doorLockedSound.run(.play())
                }
                
                // turn on signalization!
                turnSignalizationOn(of: car)
                
                // push message to chat and exit
                return scene.pushMessageToChat(text: "Беги!!!")
            }
            
        }
    }
    
    // this turns on car signalization sound and light blinking
    func turnSignalizationOn(of car: Car) {
    
        // play car signalization sound if found it
        if let signalizationSound = car.node?.childNode(withName: Sound.car_signalization.rawValue) {
            signalizationSound.run(.play())
        }
    
        // blick lights
        car.blinkLightSignals()
        car.signaling = true
    }
    
    // player enters in the car
    func getIn(the car: Car) {
        
        if car.stolen == false {
            // play door open sound and engine starts
            // play door closed sound if found it
            if let doorLockedSound = car.node?.childNode(withName: Sound.car_door_locked.rawValue) {
                doorLockedSound.run(.play()) {
                    // play engine start sound if found it
                    if let engineStartSound = car.node?.childNode(withName: EngineSound.old_copper_engine_start.rawValue) {
                        engineStartSound.run(.play()) {
                            car.engineStarted = true
                        }
                    }
                }
            }
        } else {
            // else just engine starts
            // play engine start sound if found it
            if let engineStartSound = car.node?.childNode(withName: EngineSound.old_copper_engine_start.rawValue) {
                engineStartSound.run(.play()) {
                    car.engineStarted = true
                }
            }
        }
        // start smoke
        car.startEngine()
        
        // remove enter to car button
        self.scene.enterToCarBtn?.removeFromParent()
        self.scene.enterToCarBtn = nil
        
        // change lock type in target square popup
        self.currLockTarget = nil
        let lockLabel = self.scene.targetWindow?.childNode(withName: "lockTypeLabel")
        lockLabel?.removeFromParent()
        
        // remove lock complexity square pop up
        self.scene.targetWindow?.childNode(withName: "complexity-label")?.removeFromParent()
        
        // change size of the target square to fit entrail's height
        let newHeight = self.scene.getHeightOfAllNodesInTargetSquare()
        self.scene.adjustSizeOfTargetWindow(to: newHeight)
        
        // remove target circle sprite from tilemap
        self.scene.targetCircleSprite?.removeFromParent()
        
        // off collision
        self.node?.physicsBody?.categoryBitMask = 0
        self.node?.physicsBody?.contactTestBitMask = 0
        self.node?.physicsBody?.collisionBitMask = 0
        
        // hide player
        self.node?.alpha = 0
        
        // position player in the center of car
        self.node?.position = car.node!.position
        
        // position camera to the center of car
        self.scene.cameraNode?.position = car.node!.position
        
        // set player state to sittin in car
        self.isSittingInCar = true
        
        // set moving camera to false
        self.scene.canMoveCamera = false
        
        // zoom out camera a bit
        self.scene.zoomCamera(to: self.scene.minScale + 1.20, duration: 0.9)
        
        // Rotate camera to back of the car by shortest axis
        self.scene.cameraNode?.run(SKAction.rotate(toAngle: car.node!.zRotation + (270 * (Double.pi/180)), duration: 0.9, shortestUnitArc: true))
        
        // switch to driving ui
        self.scene.switchToCarDrivingUI()
        
        // turning off gestures so we can use multitouch for driving
        self.scene.turnOffGestureRecognizer()
        
        // set car that player currently driving
        self.drivingCar = car
        
        // unlock all locks when you are got in the car
        for lock in car.unlockedLocks {
            car.unlockedLocks[lock.key] = true
        }
        
        car.stolen = true
        
        // remove dot from minimap sprite node
        // for to position in at the same place as player dot
        car.miniMapDot?.removeFromParent()
        car.miniMapDot = SKShapeNode(rectOf: CGSize(width: 4, height: 4))
        car.miniMapDot?.fillColor = .green
        
        self.scene.miniMapCropNode?.addChild(car.miniMapDot!)
    }
    
    func getOutOfCar() {
        
        // stop sounds
        if let drivingSound = self.drivingCar?.engineDrivingSound,
           let acceleratingSound = self.drivingCar?.engineAcceleratingSound {
            drivingSound.run(.stop())
            acceleratingSound.run(.stop())
        }
   
        // turning On gestures so we can use zoom in and out
        self.scene.setupGestureRecognizer()
        
        // show player
        self.node?.alpha = 1
        
        // rotate camera back to normal initial position
        self.scene.cameraNode?.zRotation = self.scene.initialCameraRotation!
        
        let futurePlayerPos = CGPoint(x: (self.drivingCar?.node?.frame.maxX)! + 50, y: (self.drivingCar?.node?.frame.midY)! + 50)
        
        // nodes at position
//        let nodesAtPos = self.scene.nodes(at: futurePlayerPos)
//        print("There are \(nodesAtPos.count) nodes at that point")
//        print(nodesAtPos)
        
        // position player around the car
        self.node?.position = futurePlayerPos
        
        // set destination position the same as player position
        self.destinationPosition = futurePlayerPos
        
        // position camera to the player
        self.scene.cameraNode?.position = futurePlayerPos
        
        // return back physic body collision
        self.node?.physicsBody?.categoryBitMask = self.scene.playerCategory
        self.node?.physicsBody?.collisionBitMask = self.scene.boundaryCategory | self.scene.carCategory | self.scene.trashBakCategory
        
        // zoom out camera a bit
        self.scene.zoomCamera(to: self.scene.minScale + 0.20, duration: 0.7)
        
        // set player state to not in car
        self.scene.player?.isSittingInCar = false
        
        // switch to usual ui
        self.scene.switchToUsualUI()
        
        // set car that player currently driving to nil
        self.scene.player?.drivingCar = nil
        
        // now can move camera
        self.scene.canMoveCamera = true
        
        // return back mini map dot of the player
        // add player dot to mini map
        let miniMapDot = SKShapeNode(circleOfRadius: 3)
        miniMapDot.fillColor = .orange
        self.scene.miniMapCropNode!.addChild(miniMapDot)
        
        self.miniMapDot = miniMapDot

        
    }
    
    func pickUpTargetItem() {
        if currTargetItem == nil { return }
        
        // remove item from level
        let index = scene.itemsOnLevel.firstIndex(of: currTargetItem!)
        scene.itemsOnLevel.remove(at: index!)
        currTargetItem?.node.removeFromParent()
        
        // add to inventory
        inventory.append(currTargetItem)
        
        // play sound of pick up
        scene.run(InventorySounds.pickup_inventory.action)
        
        // hide windows
        scene.hideTargetWindow()
        scene.hideTaskScreen()
        
        print("Now items on level:",  scene.itemsOnLevel)
        print("Now in inventory: ", self.inventory)
    }
    
}
