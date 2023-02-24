
import SpriteKit
import GameplayKit

class ParkingWorkGame: SKScene {
    
    // Display Size
    let displaySize = UIScreen.main.bounds
    var displayWidth: CGFloat?
    var displayHeight: CGFloat?
    
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
    
    // Camera Ends
    var rightTopCameraEnd: CGPoint? = nil
    var leftBottomCameraEnd: CGPoint? = nil
    
    // End of the World
    var rightTopEnd: CGPoint?
    var leftBottomEnd: CGPoint?
    
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
        
        // detect PINCH to increase zoom
//        let pinch = UIPinchGestureRecognizer()
    
    }
    
    // MARK: - Initial Game Values Setup
    /// Setup all initial values (or variables) needed for start the game
    func setupInitialGameValues() {
        
        // initial player location destionation the same as player position
        playerLocationDestination = player?.position
        
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
        
        // set right and left boundaries of the tilemap
        let tileNode = self.childNode(withName: "tilemapLevel1")
        
        let rightX = (tileNode?.position.x)! + ((tileNode?.frame.width)! / 3)
        let rightY = (tileNode?.position.y)! + ((tileNode?.frame.height)! / 2.5)
        let leftX = (tileNode?.position.x)! - ((tileNode?.frame.width)! / 3)
        let leftY = (tileNode?.position.y)! - ((tileNode?.frame.height)! / 2.5)
        
        rightTopEnd = CGPoint(x: rightX, y: rightY)
        leftBottomEnd = CGPoint(x: leftX, y: leftY)
        
        // intialize possible player states
        playerStateMachine = GKStateMachine(states: [
            WalkingState(player: player!),
            IdleState(player: player!)
        ])
    }
    
    func updateCameraEdges() {
        
        let rightX = (cameraNode?.position.x)! + (displayWidth! / 2)
        let rightY = (cameraNode?.position.y)! + (displayHeight! / 2)
        
        let leftX = (cameraNode?.position.x)! - (displayWidth! / 2)
        let leftY = (cameraNode?.position.y)! - (displayHeight! / 2)
        
        rightTopCameraEnd = CGPoint(x: rightX, y: rightY)
        leftBottomCameraEnd = CGPoint(x: leftX, y: leftY)
    }
    
}
