//
//  LevelList.swift
//  Parking Work
//
//  Created by Николай Ногин on 29.05.2023.
//

import SpriteKit

class LevelList: ParkingWorkGame {
    
    let levelList = [
        ("Уровень 1", "Привет, Босс"),
        ("Уровень 2", "Сообщение 2"),
        ("Уровень 3", "Сообщение 3"),
        ("Уровень 4", "Cообщение 4"),
        ("Уровень 5", "Cообщение 5")
    ]
    
    var leftSide: SKSpriteNode?
    var rightSide: SKSpriteNode?
    var levelPic: SKSpriteNode?
    var levelDescSprite: SKSpriteNode?
    var startButton: SKSpriteNode?
    var connectionSprite: SKSpriteNode?
    
    var myReputationLabel: SKLabelNode?
    var mainHeader: SKLabelNode?
    var reputationNeededLabel: SKLabelNode?
    var levelPicture: SKLabelNode?
 
    var levelDescLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupInitialGameValues()
        
        setupLevelListScreen()
        
        fillLevels()
        
        animateStartButton()
    }
    
    override func setupInitialGameValues() {
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
        
        // sprites setup
        leftSide = childNode(withName: "LeftSideSprite") as? SKSpriteNode
        rightSide = childNode(withName: "RightSideSprite") as? SKSpriteNode
        
        // labels setup
        mainHeader = leftSide?.childNode(withName: "MainHeader") as? SKLabelNode
        reputationNeededLabel = leftSide?.childNode(withName: "ReputationNeededLabel") as? SKLabelNode
        levelPic = leftSide?.childNode(withName: "LevelPicture") as? SKSpriteNode
        levelDescSprite = leftSide?.childNode(withName: "DescriptionSprite") as? SKSpriteNode
        levelDescLabel = levelDescSprite?.childNode(withName: "LevelDescription") as? SKLabelNode
        startButton = leftSide?.childNode(withName: "StartButton") as? SKSpriteNode
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
//            let location = touch.location(in: self)
            
            // buttons pressed check
//            let touchedNode = atPoint(location)
            print("touch")
        }
    }
    
    func setupLevelListScreen() {
        //sprites setup
        // left side sprite
        leftSide?.size = CGSize(width: displayWidth! / 2, height: displayHeight!)
        leftSide?.zRotation = 0
        leftSide?.anchorPoint = CGPoint(x: 1, y: 0)
        leftSide?.position = CGPoint(x: 0, y: (-displayHeight! / 2))
        
        // right side sprite
        rightSide?.size = CGSize(width: displayWidth! / 2, height: displayHeight!)
        rightSide?.zRotation = 0
        rightSide?.anchorPoint = CGPoint(x: 0, y: 0)
        rightSide?.position = CGPoint(x: 1, y: (-displayHeight!) / 2)
        rightSide?.color = UIColor.clear

        mainHeader?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (leftSide?.frame.height)! - 35)
        mainHeader?.verticalAlignmentMode = .center
        mainHeader?.horizontalAlignmentMode = .center
        
        reputationNeededLabel?.verticalAlignmentMode = .center
        reputationNeededLabel?.horizontalAlignmentMode = .center
        reputationNeededLabel?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (mainHeader?.position.y)! - (mainHeader?.frame.height)! )
        
        levelPic?.anchorPoint = CGPoint(x: 0.5, y: 1)
        levelPic?.size = CGSize(width: (leftSide?.frame.height)! / 2.6, height: (leftSide?.frame.height)! / 2.6 )
        levelPic?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (reputationNeededLabel?.position.y)! - ((reputationNeededLabel?.frame.height)!))
        
        
        levelDescSprite?.size = CGSize(width: displayWidth! / 2 - 20, height: (levelDescLabel?.frame.height)! + 20)
        levelDescSprite?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (levelPic?.position.y)! - ((levelPic?.frame.height)! + 40))
        
        levelDescLabel?.horizontalAlignmentMode = .center
        levelDescLabel?.verticalAlignmentMode = .center
        levelDescLabel?.preferredMaxLayoutWidth = displayWidth! * 2
        levelDescLabel?.position = CGPoint(x: 0, y: 0)

        startButton?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        startButton?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (levelDescSprite?.position.y)! - ((levelDescSprite?.frame.height)! + 10))
        
    }
    
    func fillLevels() {
        var levelSprite: SKSpriteNode?
        var connectionSprite: SKSpriteNode?
        var levelNumLabel: SKLabelNode?
        var subtextLabel: SKLabelNode?
        
        var runFist = true
        var prevPos: CGPoint?
        for (levelNum, levelHeader) in levelList {
            print(levelNum, levelHeader)
            
            if runFist {
                runFist = false
                levelSprite = rightSide?.childNode(withName: "Level1Sprite") as? SKSpriteNode
                levelSprite?.size = CGSize(width: (rightSide?.size.width)!, height: 80)
                levelSprite?.anchorPoint = CGPoint(x: 0, y: 0)
                levelSprite?.position = CGPoint(x: 0, y: 0)
                prevPos = levelSprite?.position
                
                connectionSprite = levelSprite?.childNode(withName: "ConnectionSprite") as? SKSpriteNode
                connectionSprite?.position = CGPoint(x: 0, y: (levelSprite?.frame.height)! / 2)
            }
            else {
                print()
                levelSprite = levelSprite?.copy() as? SKSpriteNode
                levelSprite?.name = "Level\(levelNum.split(separator: " ")[1])Sprite"
                levelSprite?.childNode(withName: "ConnectionSprite")?.alpha = 0
                levelSprite?.alpha = 0.74
                levelSprite?.position = CGPoint(x: 0, y: prevPos!.y + (levelSprite?.frame.height)! + 1)
                prevPos = levelSprite?.position
                rightSide?.addChild(levelSprite!)
            }
            
            levelNumLabel = levelSprite?.childNode(withName: "LevelNumLabel") as? SKLabelNode
            levelNumLabel?.text = levelNum
            
            levelNumLabel?.horizontalAlignmentMode = .center
            levelNumLabel?.verticalAlignmentMode = .center
            levelNumLabel?.position = CGPoint(x: (levelSprite?.frame.width)! / 2, y: (levelSprite?.frame.height)! / 2)
            
            subtextLabel = levelSprite?.childNode(withName: "SubtextLabel") as? SKLabelNode
            subtextLabel?.text = levelHeader
            subtextLabel?.verticalAlignmentMode = .bottom
            subtextLabel?.horizontalAlignmentMode = .center
            subtextLabel?.position = CGPoint(x: (levelSprite?.frame.width)! / 2 + 62, y: (levelNumLabel?.position.y)! - 36)
            
        }
    }
    
    func animateStartButton() {
        startButton?.run(SKAction.repeatForever(.sequence([SKAction.fadeAlpha(to: 0.6, duration: 2.0), SKAction.fadeAlpha(to: 1.0, duration: 2.0)])))
        startButton?.run(SKAction.repeatForever(.sequence([SKAction.scale(to: 1.05, duration: 1.0), SKAction.scale(to: 1.0, duration: 0.6)])))
    }
    
}
