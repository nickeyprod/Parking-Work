
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
    
    // Time
    var previousTimeInterval: TimeInterval = 0
    
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
    
    // Physic body categories
    let playerCategory: UInt32 = 1 << 1
    let lockCategory: UInt32 = 1 << 2
    let carCategory: UInt32 = 1 << 3
    let boundaryCategory: UInt32 = 1 << 4
    
    // Cars
    var oldCopper: SKNode?

    enum Cars: String {
        case OldCopper = "OldCopper"
        
        enum Chowerler {
            static var node = SKNode()
            static var name = "Chowerler"
            enum locks {
//                static var driverLock = SKNode()
//                static var passengerLock = SKNode()
                case driverLock, passengerLock
            }
            enum locksComplexity {
                static var driverLock = 0.90
                static var passengerLock = 0.87
            }
        }
    }
    
    
    func setupPlayer() {
        // player
        player = self.childNode(withName: "playerNode")
        player?.physicsBody?.categoryBitMask = playerCategory
        player?.physicsBody?.collisionBitMask = boundaryCategory | carCategory
        player?.zPosition = 10
        
    }
    
    func setupCars() {
        // cars
        
        // Old Copper
        oldCopper = self.childNode(withName: Cars.OldCopper.rawValue)

//        oldCopper.node =
//        oldCopper.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Cars.OldCopper.rawValue), size: CGSize(width: 460, height: 200))
//
//        oldCopper.physicsBody?.categoryBitMask = carCategory
//        oldCopper.physicsBody?.affectedByGravity = false
//        oldCopper.physicsBody?.isDynamic = false
        
        // Chowerler
//        Cars.Chowerler.node = self.childNode(withName: Cars.Chowerler.name)!
//        Cars.Chowerler.node.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Cars.Chowerler.name), size: CGSize(width: 258.363, height: 506.244))
//
//        Cars.Chowerler.node.physicsBody?.categoryBitMask = carCategory
//        Cars.Chowerler.node.physicsBody?.affectedByGravity = false
//        Cars.Chowerler.node.physicsBody?.isDynamic = false
    }
    
    func setupCarLocks() {
        // car locks
        let oldCopperDriver = oldCopper!.childNode(withName: "driver_lock")
        let oldCopperPassengerLock = oldCopper!.childNode(withName: "passenger_lock")
        
        // OldCopper driver lock
        oldCopperDriver?.physicsBody = SKPhysicsBody(rectangleOf: (oldCopperDriver?.frame.size)!)
        oldCopperDriver?.physicsBody?.categoryBitMask = lockCategory
        oldCopperDriver?.physicsBody?.contactTestBitMask = playerCategory
        oldCopperDriver?.physicsBody?.affectedByGravity = false
        oldCopperDriver?.physicsBody?.isDynamic = false
        
        // OldCopper passenger lock
        oldCopperPassengerLock?.physicsBody = SKPhysicsBody(rectangleOf: (oldCopperPassengerLock?.frame.size)!)
        oldCopperPassengerLock?.physicsBody?.categoryBitMask = lockCategory
        oldCopperPassengerLock?.physicsBody?.contactTestBitMask = playerCategory
        oldCopperPassengerLock?.physicsBody?.affectedByGravity = false
        oldCopperPassengerLock?.physicsBody?.isDynamic = false

    }
    
    func setupWorldBoundaries() {
        // player collides with this `end of the world` boundaries
        for i in 0...6 {
            let worldBoundary = self.childNode(withName: "boundary\(i)")
            worldBoundary?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (worldBoundary?.frame.width)!, height: (worldBoundary?.frame.height)!))
            worldBoundary?.physicsBody?.categoryBitMask = boundaryCategory
            worldBoundary?.physicsBody?.affectedByGravity = false
            worldBoundary?.physicsBody?.isDynamic = false
            worldBoundary?.alpha = 0
        }
    
    }
    
    func setupPhysicBodies() {
        
        // world bounds to collide
        setupWorldBoundaries()
        
        // player
        setupPlayer()
        
        // cars
        setupCars()
        
        // car locks
        setupCarLocks()
               
    }
    
    override func didMove(to view: SKView) {
        
        // setup physic world contact delegate to track collisions
        physicsWorld.contactDelegate = self
        
        // setup physic bodies
        setupPhysicBodies()
        
        // setup camera
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        cameraNode?.position = player!.position
        
        // setup initial values
        playerLocationDestination = player?.position
        
        playerStateMachine = GKStateMachine(states: [
            WalkingState(player: player!),
            IdleState(player: player!)
        ])
        
        // enter to initial player state
        playerStateMachine.enter(IdleState.self)

    }
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
        
        // setting 'target' sprite on ground
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

// MARK: Collisions
extension ParkingWorkGame: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("collision")
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        print("didBeginContact entered for \(String(describing: bodyA.node!.name)) and \(String(describing: bodyB.node!.name))")
        
        let contactMask = (bodyA.categoryBitMask | bodyB.categoryBitMask)
 
        switch contactMask {
        case (playerCategory | lockCategory):
            if bodyA.node!.name != "playerNode" {
                tryOpenCarLock(of: (bodyA.node?.parent!.name)!, lockType: (bodyA.node?.name)!)
            }
            else if bodyB.node!.name != "playerNode" {
                tryOpenCarLock(of: (bodyB.node?.parent!.name)!, lockType: (bodyB.node?.name)!)
            }
        default:
            print("Some other contact occurred")
        }
    }
        
}


// MARK: Player possibilities
extension ParkingWorkGame {

    func tryOpenCarLock(of carName: String, lockType: String) {
        let lockComplexity = LOCK_COMPLEXITY[carName]?[lockType]
        
        let targetCar = TargetCar(carName: carName, lockType: lockType, lockComplexity: lockComplexity!)
        
        // show message suggesting to open the target car
        self.showOpenCarMessage(of: targetCar)
        
    }
}

// MARK: Game functions
extension ParkingWorkGame {
    func showOpenCarMessage(of targetCar: TargetCar) {
        print(targetCar)
    }
}

