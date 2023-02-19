
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
    // Open Car Window
    var openCarWindow: SKNode?
    var openCarWindowNameLabel: SKLabelNode?
    var openCarWindowLockTypeLabel: SKLabelNode?
    var openCarWindowComplexityNum: SKLabelNode?
    // Open Car Success Wibdow
    var openCarSuccessWindow: SKNode?
    var openCarSuccessWindowSuccessLabel: SKLabelNode?
    var openCarSuccessWindowGarageLabel: SKLabelNode?
    var openCarSuccessWindowGoodBtn: SKNode?
    var openCarSuccessWindowGoodBtnLabel: SKLabelNode?
    
    // Time
    var previousTimeInterval: TimeInterval = 0
    
    // Movement target
    var currentSpriteTarget: SKSpriteNode?
    var targetMovementTimer: Timer?
    
    // Target
    var currTargetCar: TargetCar?
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
    
    var ownedCars: [OwnedCar?] = []
    
    // analog to 'ViewDidLoad' - runs when game scene appears
    override func didMove(to view: SKView) {
        
        // setup physic world contact delegate to track collisions
        physicsWorld.contactDelegate = self
        
    }
    
    // MARK: - Initial Game Values Setup
    /// Setup all initial values (or variables) needed for start the game
    func setupInitialGameValues() {
        playerLocationDestination = player?.position
        
        playerStateMachine = GKStateMachine(states: [
            WalkingState(player: player!),
            IdleState(player: player!)
        ])
    }
    
}
