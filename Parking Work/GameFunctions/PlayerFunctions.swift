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
            scene.hideOpenCarMessage()
            
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
        
        // turn signalization on!
        turnSignalizationOn(of: car)
        
        // hide open car message
        scene.hideOpenCarMessage()
    }
    
    // run this function when open lock successes
    func successfullyOpenedCar(car: Car, lockType: String) {
        // add it to owned cars array
        ownedCars.append(car)
        
        // remove the car from tilemap
        removeCarFromTileMap(car: car)
        
        // hide target square
        self.scene.hideTargetSquare()
        
        // hide open car window pop-up
        scene.hideOpenCarMessage()
        
        // play door open sound
        node?.run(Sound.door_open.action)
        
        // play success ring
        node?.run(Sound.success_bell.action)
        
        // show car successfuly opened message
        scene.showCarOpenedSuccessMessage(of: car)
        
        // push message to chat that open was successful
        self.scene.pushMessageToChat(text: "\(car.name) - \(LOCK_TRANSLATIONS[lockType] ?? "Тип неизвестен") - вскрытие удалось!")
        self.scene.pushMessageToChat(text: "Машина появится в вашем гараже")
    }

    // removing car node from game and from minimap,
    // also removing its anxiety circles.
    func removeCarFromTileMap(car: Car) {
        // remove car itself and its anxiety circles
        car.node?.removeFromParent()
        car.firstAnxietyCircle?.removeFromParent()
        car.secondAnxietyCircle?.removeFromParent()
        car.thirdAnxietyCircle?.removeFromParent()
        
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
                scene.hideOpenCarMessage()
                
                // turn on signalization!
                turnSignalizationOn(of: car)
                
                // push message to chat and exit
                return scene.pushMessageToChat(text: "Беги!!!")
            }
            
        }
    }
    
    // this turns on car signalization sound and light blinking
    func turnSignalizationOn(of car: Car) {
        let signal = Sound.car_signalization.audio
        let locked = Sound.car_door_locked.audio
        
        // play door closed sound & car signalization sound
        node?.parent?.addChild(locked)
        node?.parent?.addChild(signal)
        
        locked.run(SKAction.play())
        signal.run(SKAction.play())
        
        // blick lights
        scene.blinkLightSignals(of: car)
        car.signaling = true
    }
    
}
