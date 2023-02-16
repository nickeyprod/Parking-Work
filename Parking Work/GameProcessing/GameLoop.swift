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
        
        var dx = (playerLocationDestination!.x - (player?.position.x)!) * deltaTime
        var dy = (playerLocationDestination!.y - (player?.position.y)!) * deltaTime
        
        dx = dx > 0 ? PLAYER_SPEED : -PLAYER_SPEED
        dy = dy < 0 ? -PLAYER_SPEED : PLAYER_SPEED
        
        if floor(playerLocationDestination!.x) == floor((player?.position.x)!) {
            dx = 0
        }
        if floor(playerLocationDestination!.y) == floor((player?.position.y)!) {
            dy = 0
        }
        
        if dx != 0 || dy != 0 {
            playerMoving = true
        }
        
        let displacement = CGVector(dx: dx, dy: dy)
        let move = SKAction.move(by: displacement, duration: 0)
        player?.run(move)
        
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
        
        // set sprite face direction when moving horizontal/vertical
        if movingUp && !movingLeft && !movingRight {
            let action = SKAction.rotate(toAngle: 0.0449, duration: 0.1, shortestUnitArc: true)
            player?.run(action)
        } else if movingDown && !movingLeft && !movingRight {
            let action = SKAction.rotate(toAngle: 3.1449, duration: 0.1, shortestUnitArc: true)
            player?.run(action)
        } else if movingLeft && !movingUp && !movingDown {
            let action = SKAction.rotate(toAngle: 1.6449, duration: 0.1, shortestUnitArc: true)
            player?.run(action)
        } else if movingRight && !movingUp && !movingDown {

            let action = SKAction.rotate(toAngle: 4.6449, duration: 0.1, shortestUnitArc: true)
            player?.run(action)

        }
        
        // set sprite face direction when moving by diagonal
        if movingLeft && movingDown {
            let action = SKAction.rotate(toAngle: 2.6449, duration: 0.1, shortestUnitArc: true)
            player?.run(action)
        } else if movingLeft && movingUp {
            let action = SKAction.rotate(toAngle: 0.6449, duration: 0.1, shortestUnitArc: true)
            player?.run(action)
        } else if movingRight && movingUp {
            let action = SKAction.rotate(toAngle: -0.6449, duration: 0.1, shortestUnitArc: true)
            player?.run(action)
        } else if movingRight && movingDown {
            let action = SKAction.rotate(toAngle: -2.6449, duration: 0.1, shortestUnitArc: true)
            player?.run(action)
        }
        
        // player state
        if playerMoving {
            playerStateMachine.enter(WalkingState.self)
        } else {
            playerStateMachine.enter(IdleState.self)
            targetMovementTimer?.invalidate()
            currentSpriteTarget?.removeFromParent()
        }
        
        // check if need to hide open car window pop-up
        if currLockTarget != nil {
            checkDistanceBetweenPlayerAndTargetLock()
        }
    }
       
}
