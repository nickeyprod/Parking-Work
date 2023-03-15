
import SpriteKit
import GameplayKit

class ParkingWorkGame: SKScene {
    
    // Current Level Number
    var levelNum: Int = 1
    var anxietyLevel: CGFloat = 0.0
    
    // additional game screens
    var taskScreen: SKSpriteNode?
    
    // Display Size
    let displaySize = UIScreen.main.bounds
    var displayWidth: CGFloat?
    var displayHeight: CGFloat?
    
    // Nodes
    var player: SKNode?
    var cameraNode: SKCameraNode?
    var tileNode: SKTileMapNode?
    var miniMapSprite: SKSpriteNode?
    var miniMapCropNode: SKCropNode?
    
    // minimap player dot
    var miniMapPlayerDot: SKShapeNode?
    
    // tile Map dimensions
    var tileMapWidth: CGFloat?
    var tileMapHeight: CGFloat?
    
    // mini Map dimensions
    var miniMapWidth: CGFloat?
    var miniMapHeight: CGFloat?
    
    // mini map scale factor
    var miniMapScaleFactor: CGFloat = 1.4
    
    // Bools
    var sinceTouchPassedTime: Timer?
    var cameraMovingByFinger = false
    
    // Player state
    var playerStateMachine: GKStateMachine!
    var playerLocationDestination: CGPoint?
    
    // Anxiety Bar
    var anxietyBar: SKSpriteNode?
    var canReduceAnxiety: Bool = true
    
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
    var substractAnxietyTimer: Timer?
    
    // Movement target
    var currentSpriteTarget: SKSpriteNode?
    var targetMovementTimer: Timer?
    
    // Target
    var currTargetCar: Car?
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
    
    var ownedCars: [Car?] = []
    var signalignCarTimers: [Timer?] = []
    
    var prevScale: CGFloat = 0.0
    let minScale: CGFloat = 1.02
    let maxScale: CGFloat = 2.02
    
    // analog to 'ViewDidLoad' - runs when game scene appears
    override func didMove(to view: SKView) {
        // setup physic world contact delegate to track collisions
        physicsWorld.contactDelegate = self
        
        // detect PINCH to increase zoom
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler))
        self.view?.isUserInteractionEnabled = true
        self.view?.addGestureRecognizer(pinch)
    
    }
    
    // MARK: - Pinch handler (zooming In/Out)
    /// Gesture handling function for zooming in and out map
    @objc func pinchHandler(_ sender: UIPinchGestureRecognizer) {
        // this prevents camera `jumping` while moving just after zooming
        currTouchPosition = nil; startTouchPosition = nil
        
        // change zoom of the map
        if sender.state == UIGestureRecognizer.State.changed {
            if prevScale < sender.scale {
                if cameraNode!.xScale >= minScale {
                    // Zooming In
                    cameraNode?.xScale -= 0.035
                    cameraNode?.yScale -= 0.035
                }
            } else {
                if cameraNode!.xScale <= maxScale {
                    // Zooming Out
                    cameraNode?.xScale += 0.035
                    cameraNode?.yScale += 0.035
                }
            }
            // set for the next run
            prevScale = sender.scale

        }
        
    }
    
    // MARK: - Initial Game Values Setup
    /// Setup all initial values (or variables) needed for start the game
    func setupInitialGameValues() {

        
        // initial player location destionation the same as player position
        playerLocationDestination = player?.position
        
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
        
        // get tile map
        tileNode = childNode(withName: "tilemapLevel1") as? SKTileMapNode
        
        // set tile map dimensions
        tileMapWidth = tileNode?.frame.width
        tileMapHeight = tileNode?.frame.height
        
        // set mini map sprite dimensions
        miniMapWidth = miniMapSprite?.frame.width
        miniMapHeight = miniMapSprite?.frame.height
        
        // set right and left boundaries of the tilemap
        let rightX = (tileNode?.position.x)! + ((tileNode?.frame.width)! / 4)
        let rightY = (tileNode?.position.y)! + ((tileNode?.frame.height)! / 3)
        let leftX = (tileNode?.position.x)! - ((tileNode?.frame.width)! / 4)
        let leftY = (tileNode?.position.y)! - ((tileNode?.frame.height)! / 3)
        
        rightTopEnd = CGPoint(x: rightX, y: rightY)
        leftBottomEnd = CGPoint(x: leftX, y: leftY)
        
        // intialize possible player states
        playerStateMachine = GKStateMachine(states: [
            WalkingState(player: player!),
            IdleState(player: player!)
        ])
        
        // substracting anxiety
        self.substractAnxietyTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { _ in
            self.substractAnxiety()
        })
    }
    
    // detect where is now left bottom and right top angles of camera positions
    func updateCameraEdges() {
        
        let rightX = (cameraNode?.position.x)! + (displayWidth! / 2)
        let rightY = (cameraNode?.position.y)! + (displayHeight! / 2)
        
        let leftX = (cameraNode?.position.x)! - (displayWidth! / 2)
        let leftY = (cameraNode?.position.y)! - (displayHeight! / 2)
        
        rightTopCameraEnd = CGPoint(x: rightX, y: rightY)
        leftBottomCameraEnd = CGPoint(x: leftX, y: leftY)
    }
    
}
