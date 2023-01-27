
import SpriteKit
import GameplayKit

class ParkingWorkGame: SKScene {
    
    // Nodes
    var player: SKNode?
    var cameraNode: SKCameraNode?
    
    // Bools
    var sinceTouchPassedTime: Timer?
    var cameraMovingByFinger = false
    
    // Player state
    var playerStateMachine: GKStateMachine!
    var playerLocationDestination: CGPoint?
    var playerInitialPosition: CGPoint?
    var previousTimeInterval: TimeInterval = 0
    var playerPrevDirection: String?
    
    // Movement target
    var currentSpriteTarget: SKSpriteNode?
    var targetMovementTimer: Timer?
    
    var targetX: CGFloat?
    var targetY: CGFloat?
    
    // Camera position
    var startTouchPosition: CGPoint? = nil
    var currTouchPosition: CGPoint? = nil
    
    // Constants
    let PLAYER_SPEED = 1.0
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
    
        player = self.childNode(withName: "playerNode")
        player?.zPosition = 10
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        
        playerLocationDestination = player?.position
        cameraNode?.position = player!.position
        
        playerStateMachine = GKStateMachine(states: [
//            JumpingState(playerNode: player!),
            WalkingState(player: player!),
            IdleState(player: player!),
//            LandingState(playerNode: player!),
//            StunnedState(playerNode: player!)
        ])
        
        playerStateMachine.enter(IdleState.self)

    }
}

extension ParkingWorkGame: SKPhysicsContactDelegate {
    
}

// MARK: Touches
extension ParkingWorkGame {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in: self)
            if startTouchPosition == nil {
                startTouchPosition = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        cameraMovingByFinger = true
        
        for touch in touches {
            let location = touch.location(in: self)
            
            currTouchPosition = CGPoint(x: location.x, y: location.y)
            
            // movig camera logic
            if currTouchPosition != nil && startTouchPosition != nil {
                
                let diffX = startTouchPosition!.x - currTouchPosition!.x
                let diffY = startTouchPosition!.y - currTouchPosition!.y
                cameraNode?.position.x = (cameraNode?.position.x)! + diffX
                cameraNode?.position.y = (cameraNode?.position.y)! + diffY
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startTouchPosition = nil
        playerInitialPosition = player?.position
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if cameraMovingByFinger == false {
                playerLocationDestination = location
                currentSpriteTarget?.removeFromParent()
                setTarget(at: location)
            }
            
            cameraMovingByFinger = false
            
            
        }
    }
    
    func setTarget(at location: CGPoint) {
        currentSpriteTarget = SKSpriteNode(imageNamed: "target")
        currentSpriteTarget!.position = location
        currentSpriteTarget!.xScale = 0.2
        currentSpriteTarget!.yScale = 0.2
        currentSpriteTarget?.zPosition = 0
        currentSpriteTarget?.colorBlendFactor = 0.4
        addChild(currentSpriteTarget!)
        
        targetRotate(target: currentSpriteTarget!)
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
}


// MARK: Game Loop
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
        
        // sprite state
        if playerMoving {
            playerStateMachine.enter(WalkingState.self)
        } else {
            playerStateMachine.enter(IdleState.self)
            targetMovementTimer?.invalidate()
            currentSpriteTarget?.removeFromParent()
        }
        
    }
       
}
