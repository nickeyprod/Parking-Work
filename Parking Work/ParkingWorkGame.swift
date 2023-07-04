
import SpriteKit
import GameplayKit
import CoreData

class ParkingWorkGame: SKScene {
    
    // Core Data Game Storage
    let storage = Storage()
    
    // Initial rotation of the camera at start of the game
    var initialCameraRotation: CGFloat?
    
    // Current Mission Number
    var missionNum: Int = 1
    var anxietyLevel: CGFloat = 0.0
    var missionCompleted: Bool = false
    
    // additional game screens
    var taskScreen: SKSpriteNode?
    var menuScreen: SKSpriteNode?
    var settingsScreen: SKSpriteNode?
    var inventoryScreen: SKSpriteNode?
    
    // Display Size
    let displaySize = UIScreen.main.bounds
    var displayWidth: CGFloat?
    var displayHeight: CGFloat?
    
    // Chat Size
    let CHAT_HEIGHT = 110
    let CHAT_WIDTH = 200
    
    // CHAT
    var chatSliderBottomPos: CGPoint?
    var chatSliderTopPos: CGPoint?
    var currScrollingStep: CGFloat?
    var chatSliderHeight: CGFloat?
    var initialSliderDiff: CGFloat?
    var initialScrollingDiff: CGFloat?
    var sliderTouchIsHolded: Bool = false
    var prevTouchPos: CGPoint? = CGPoint(x: 0, y: 0)
    
    // Nodes
    var player: Player?
    var cameraNode: SKCameraNode?
    var tileNode: SKTileMapNode?
    var miniMapSprite: SKSpriteNode?
    var miniMapCropNode: SKCropNode?
    var anxietyOuterShape: SKShapeNode?
    var anxietyInnerSprite: SKSpriteNode?
    
    // UI Buttons
    var runButton: SKShapeNode?
    var taskButton: SKShapeNode?
    var menuButton: SKShapeNode?
    var inventoryButton: SKSpriteNode?
    
    // Driving button
    var brakeButton: SKShapeNode?
    var exitFromCarBtn: SKSpriteNode?
    var enterToCarBtn: SKSpriteNode?
    
    // Turn driving buttons
    var leftButton: SKSpriteNode?
    var rightButton: SKSpriteNode?
    
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
    var cameraZooming = false
    var animatedAnxietyFirst: Bool = false
    var animatedAnxietySecond: Bool = false
    var isRunButtonHolded: Bool = false
    
    var playerInFirstCircle: Bool = false
    var playerInSecondCircle: Bool = false
    var playerInThirdCircle: Bool = false
    var canGoFromDoor: Bool = false
    var canRotate: Bool = true
    
    // this bools are all false when game is first played
    var tutorialEnded: Bool = false
    var firstCarOpened: Bool = false
    var canMoveCamera: Bool = false
    var restart: Bool = false
    
    // driving bools
    var driveBtnHolded: Bool = false
    
    var brakeBtnHolded: Bool = false
    var leftArrowHolded: Bool = false
    var rightArrowHolded: Bool = false
    var isUILocked: Bool = false
    var canPlayCrashSound: Bool = true
    var canPlayBoundaryCrashSound: Bool = true
    var canShowCompletionMissionMessage: Bool = true
    
    var isInventoryOpened: Bool = false
    
    var playerInCircleOfCar: SKNode? = nil
    
    // Player state
    var playerStateMachine: GKStateMachine!
    
    // Anxiety Bar
    var anxietyBar: SKSpriteNode?
    var canReduceAnxiety: Bool = true
    
    // Action Message window
    var actionMessageWindow: SKNode?
    var itemChoosingWindow: SKNode?
    
    // Target Window
    var targetWindow: SKSpriteNode?
    var targetWindowNameLabel: SKLabelNode?
    var targetWindowLockTypeLabel: SKLabelNode?
    var targetWindowComplexityNum: SKLabelNode?
    
    // Tutorial Window
    var tutorialWindow: SKShapeNode?
    
    var windowChat: SKCropNode?
    var scrollingChatNode: SKSpriteNode?
    var chatSlider: SKSpriteNode?
    
    // Open Car Success Wibdow
    var openCarSuccessWindow: SKNode?
    var openCarSuccessWindowSuccessLabel: SKLabelNode?
    var openCarSuccessWindowGarageLabel: SKLabelNode?
    var openCarSuccessWindowGoodBtn: SKNode?
    var openCarSuccessWindowGoodBtnLabel: SKLabelNode?
    
    // target window label positions
    var targetWindowInitialHeight: CGFloat?
    var targetWindowNameLabelPos: CGPoint?
    var targetWindowLockTypeLabelPos: CGPoint?
    var targetWindowComplexityLabelPos: CGPoint?
    
    // Time
    var previousTimeInterval: TimeInterval = 0
    var substractAnxietyTimer: Timer?
    
    // Movement target
    var targetCircleSprite: SKSpriteNode?
    var targetMovementTimer: Timer?
    
    // Camera position
    var startTouchPosition: CGPoint? = nil
    var currTouchPosition: CGPoint? = nil
    var startTouchNode: SKNode? = nil
    
    // Camera Ends
    var rightTopCameraEnd: CGPoint? = nil
    var leftBottomCameraEnd: CGPoint? = nil
    
    // End of the World
    var rightTopEnd: CGPoint?
    var leftBottomEnd: CGPoint?
    
    // Physic body categories
    let playerCategory: UInt32 = 1 << 1
    let lockCategory: UInt32 = 1 << 2
    let carCategory: UInt32 = 1 << 3
    let boundaryCategory: UInt32 = 1 << 4
    
    let firstCircleCategory: UInt32 = 1 << 5
    let secondCircleCategory: UInt32 = 1 << 6
    let thirdCircleCategory: UInt32 = 1 << 7
    
    let pigeonCategory: UInt32 = 1 << 8
    let trashBakCategory: UInt32 = 1 << 9
    let completionSquareCategory: UInt32 = 1 << 10
    let lightCategory: UInt32 = 1 << 11
    let gameItemCategory: UInt32 = 1 << 12
    
    var messagesInChat: [SKLabelNode?] = []
    
    var prevScale: CGFloat = 0.0
    let minScale: CGFloat = 1.02
    let maxScale: CGFloat = 2.02
    
    var pinch: UIPinchGestureRecognizer?
    
    // all items that it is on the mission
    var itemsOnMission: [GameItem?] = []
    
    // default to open car
    var actionMessageType: MESSAGES_TYPES = .OpenCarAction
    
    var upperPopUpMessage: SKShapeNode?
    var visibleUpperPopUpPos: CGPoint?
    
    deinit {
        print("deinit MAIN")
    }
    
    // analog to 'ViewDidLoad' - runs when game scene appears
    override func didMove(to view: SKView) {
        // load game progress
        loadGameProgress()
        
        // setup physic world contact delegate to track collisions
        physicsWorld.contactDelegate = self
        
        // detect PINCH to increase zoom
        self.setupGestureRecognizer()
                
    }

    
    // MARK: - Pinch handler (zooming In/Out)
    /// Gesture handling function for zooming in and out map
    @objc func pinchHandler(_ sender: UIPinchGestureRecognizer) {

        if self.isPaused || !tutorialEnded || !canMoveCamera {
            return
        }

        // this prevents camera `jumping` while moving just after zooming
        currTouchPosition = nil; startTouchPosition = nil;
        
        // change zoom of the map
        // num of touches prevents from bug when zooming with run btn pressed
        if (sender.numberOfTouches != 1) && sender.state == UIGestureRecognizer.State.changed {
            
            cameraZooming = true
            
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
        
        if (sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled ) {
            cameraZooming = false
            self.isRunButtonHolded = false
            self.runButton?.run(.scale(to: 1.0, duration: 0))
        }
        
  
    }
    
    // MARK: - Initial Game Values Setup
    /// Setup all initial values (or variables) needed for start the game
    func setupInitialGameValues() {
        
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
        
        // get tile map
        tileNode = childNode(withName: "tilemapMission1") as? SKTileMapNode
        
        // set tile map dimensions
        tileMapWidth = tileNode?.frame.width
        tileMapHeight = tileNode?.frame.height
        
        // initial player location destionation the same as player position
        player?.destinationPosition = player?.node?.position
        
        // set mini map sprite dimensions
        miniMapWidth = miniMapSprite?.frame.width
        miniMapHeight = miniMapSprite?.frame.height
        
        // set right and left boundaries of the tilemap
        let rightX = (tileNode?.position.x)! + ((tileNode?.frame.width)! / 3)
        let rightY = (tileNode?.position.y)! + ((tileNode?.frame.height)! / 3)
        let leftX = (tileNode?.position.x)! - ((tileNode?.frame.width)! / 4)
        let leftY = (tileNode?.position.y)! - ((tileNode?.frame.height)! / 3)
        
        // get right TOP and left BOTTOM end points of the tilemap
        rightTopEnd = CGPoint(x: rightX, y: rightY)
        leftBottomEnd = CGPoint(x: leftX, y: leftY)
        
        // intialize possible player states
        playerStateMachine = GKStateMachine(states: [
            WalkingState(player: player!.node!),
            RunningState(player: player!.node!),
            IdleState(player: player!.node!)
        ])
        
        self.listener = cameraNode
        
        // initialize timer for substracting anxiety
        self.substractAnxietyTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { _ in
            if (self.isPaused)  { return }
            self.reduceAnxiety(to: 1)
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
    
    func setupGestureRecognizer() {
        self.pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler))
        self.view?.isUserInteractionEnabled = true
        self.view?.addGestureRecognizer(self.pinch!)
    }
    
    func turnOffGestureRecognizer() {
        self.view?.removeGestureRecognizer(self.pinch!)
        for gesture in (self.view?.gestureRecognizers)! {
            gesture.isEnabled = false
            gesture.removeTarget(self, action: #selector(pinchHandler))
        }
    }
    
}
