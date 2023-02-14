
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
    
    // Message windows
    var openCarWindow: SKNode?
    var openCarWindowNameLabel: SKLabelNode?
    var openCarWindowLockTypeLabel: SKLabelNode?
    var openCarWindowComplexityNum: SKLabelNode?
    
    // Time
    var previousTimeInterval: TimeInterval = 0
    
    // Movement target
    var currentSpriteTarget: SKSpriteNode?
    var targetMovementTimer: Timer?
    
    // Lock target
    var currLockTarget: SKNode?
    
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
    var chowerler: SKNode?

    enum Cars: String {
        case OldCopper = "OldCopper"
        case Chowerler = "Chowerler"
    }
    
    // analog to 'ViewDidLoad' - runs when game scene appears
    override func didMove(to view: SKView) {
        
        // setup physic world contact delegate to track collisions
        physicsWorld.contactDelegate = self
        
        // setup physic bodies
        setupPhysicBodies()
        
        // setup camera
        setupCamera()
        
        // setup pop-up windows
        setupPopUpWindowMessages()
        
        // setup initial values needed for start the game
        setupInitialGameValues()
        
        // enter to initial player state
        playerStateMachine.enter(IdleState.self)

    }
}
