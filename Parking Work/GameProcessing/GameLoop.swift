//
//  GameLoopProcessing.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Game Loop Processing
extension ParkingWorkGame {
    override func update(_ currentTime: TimeInterval) {
        
        var playerMoving = false
        
        var movingLeft = false
        var movingRight = false
        var movingUp = false
        var movingDown = false
        
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
       
        var dx = (player!.destinationPosition!.x - player!.node!.position.x) * deltaTime
        var dy = (player!.destinationPosition!.y - player!.node!.position.y) * deltaTime
        
        // if not holded - usual speed
        if !isRunButtonHolded {
            dx = dx > 0 ? PLAYER_SPEED : -PLAYER_SPEED
            dy = dy < 0 ? -PLAYER_SPEED : PLAYER_SPEED
        } else {
            // if holded, add 0.7 to speed
            dx = dx > 0 ? PLAYER_SPEED + 0.7 : -(PLAYER_SPEED + 0.7)
            dy = dy < 0 ? -(PLAYER_SPEED + 0.7) : PLAYER_SPEED + 0.7
        }

        if floor(player!.destinationPosition!.x) == floor(player!.node!.position.x) {
            dx = 0
        }
        if floor(player!.destinationPosition!.y) == floor(player!.node!.position.y) {
            dy = 0
        }
        
        if dx != 0 || dy != 0 {
            playerMoving = true
        }

        let displacement = CGVector(dx: dx, dy: dy)
        let move = SKAction.move(by: displacement, duration: 0)
        player!.node!.run(move)
        
        // detect sprite movement direction
        if dx > 0 {
            movingRight = true
        }
        
        if dx < 0 {
            movingLeft = true
        }
        
        if dy > 0 {
            movingUp = true
        }
        
        if dy < 0 {
            movingDown = true
        }
        if canRotate == true {
            // set sprite face direction when moving by diagonal
            if movingLeft && movingDown {
                let action = SKAction.rotate(toAngle: 2.6449, duration: 0.3, shortestUnitArc: true)
                player!.node!.run(action)
            } else if movingLeft && movingUp {
                let action = SKAction.rotate(toAngle: 0.6449, duration: 0.3, shortestUnitArc: true)
                player!.node!.run(action)
            } else if movingRight && movingUp {
                let action = SKAction.rotate(toAngle: -0.6449, duration: 0.3, shortestUnitArc: true)
                player!.node!.run(action)
            } else if movingRight && movingDown {
                let action = SKAction.rotate(toAngle: -2.6449, duration: 0.3, shortestUnitArc: true)
                player!.node!.run(action)
            }
            
            // set sprite face direction when moving horizontal/vertical
            if movingUp && !movingLeft && !movingRight && !movingDown {
                let action = SKAction.rotate(toAngle: 0.0449, duration: 0.1, shortestUnitArc: true)
                player!.node!.run(action)
            } else if movingDown && !movingLeft && !movingRight && !movingUp {
                let action = SKAction.rotate(toAngle: 3.1449, duration: 0.1, shortestUnitArc: true)
                player!.node!.run(action)
            } else if movingLeft && !movingUp && !movingDown && !movingRight {
                let action = SKAction.rotate(toAngle: 1.6449, duration: 0.1, shortestUnitArc: true)
                player!.node!.run(action)
            } else if movingRight && !movingUp && !movingDown && !movingLeft {
                
                let action = SKAction.rotate(toAngle: 4.6449, duration: 0.1, shortestUnitArc: true)
                player!.node!.run(action)
                
            }
        }
        // player state
        if playerMoving && !isRunButtonHolded {
            playerStateMachine.enter(WalkingState.self)
        }
        else if playerMoving && isRunButtonHolded {
            playerStateMachine.enter(RunningState.self)
            
        }
        else {
            playerStateMachine.enter(IdleState.self)
            targetMovementTimer?.invalidate()
            targetCircleSprite?.alpha = 0
        }
        
        // check if need to hide open car window pop-up
        if player?.currLockTarget != nil {
            checkDistanceBetweenPlayerAndTargetLock()
        }
        if openCarWindow?.alpha == 1 && canGoFromDoor == false {
            canGoFromDoor = true
            player?.destinationPosition = player?.node?.position
            self.playerStateMachine.enter(IdleState.self)
        }
        
        // update left bottom and right top angle positions of the camera
        updateCameraEdges()
        
        // update player position dot on mini map
        updateMiniMapPlayerPos()
        
        // color anxiety bar
        hightLightAnxietyBar()
        
        // if anxiety 140 or above, calling cops
        if self.anxietyLevel >= 142.0 {
            callCops()
        }
 
        if (player!.currLockTarget != nil &&
            player?.currTargetCar?.node?.name == playerInCircleOfCar?.name) {

            if (playerInFirstCircle ) {
                if player?.currTargetCar?.signaling == true {
                    raiseAnxiety(to: 0.4)
                } else {
                    raiseAnxiety(to: 0.2)
                }

            }
            else if (playerInSecondCircle) {
                if player?.currTargetCar?.signaling == true {
                    raiseAnxiety(to: 0.25)
                } else {
                    raiseAnxiety(to: 0.15)
                }
            }
            else if (playerInThirdCircle) {
                if player?.currTargetCar?.signaling == true {
                    raiseAnxiety(to: 0.15)
                } else {
                    raiseAnxiety(to: 0.1)
                }
                
            }
        }
    }
    
    func callCops() {
        
        let gameOverScene = SKScene(fileNamed: "GameOverScene") as? GameOver
        let transition = SKTransition.fade(with: .black, duration: 1.0)
        let displaySize: CGRect = UIScreen.main.bounds
        // Set the scale mode to scale to fit the window
        gameOverScene?.scaleMode = .aspectFill
        gameOverScene?.size = displaySize.size
        self.view?.presentScene(gameOverScene!, transition: transition)
    }
       
}
