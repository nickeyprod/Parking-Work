//
//  LevelList.swift
//  Parking Work
//
//  Created by Николай Ногин on 29.05.2023.
//

import SpriteKit

class LevelList: ParkingWorkGame {
    
    let levelList = [
        Level(number: 1, mainHeader: "Привет, Босс", reputationForEnter: 0.0, shortDescription: "Парковка №17, р-н Чиперово, г. Сероветск."),
        Level(number: 2, mainHeader: "Header 2", reputationForEnter: 6.0, shortDescription: "... Сообщение .... 2"),
        Level(number: 3, mainHeader: "Header 3", reputationForEnter: 16.0, shortDescription: "... Сообщение .... 3"),
        Level(number: 4, mainHeader: "Header 4", reputationForEnter: 19.0, shortDescription: "... Сообщение .... 4"),
        Level(number: 5, mainHeader: "Header 5", reputationForEnter: 22.0, shortDescription: "... Сообщение .... 5")
    ]
    
    // sprite nodes
    var leftSide: SKSpriteNode?
    var leftSideWithEffect: SKEffectNode?
    var rightSide: SKSpriteNode?
    var levelPic: SKSpriteNode?
    var levelDescSprite: SKSpriteNode?
    var startButton: SKSpriteNode?
    
    // current selected level
    var currSelectedLevel: Int?
    
    // level description (left pane)
    var mainHeader: SKLabelNode?
    var reputationNeededLabel: SKLabelNode?
    var levelPicture: SKLabelNode?
    var levelDescLabel: SKLabelNode?

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // setup all needed variables
        setupInitialGameValues()
        
        // load player saved progess in the game
        loadPlayerProgress()
        
        // setup right pane (level list cells)
        fillLevelListSpriteCells()
        
        // select last opened level
        selectLastOpenedLevel()
        
        // fill left pane (current selected level description)
        fillCurrSelectedLevelDescription()
        
        // background sound
        run(.repeatForever(LevelListSounds.level_list_car_passing_by.action))
    }
    
    func loadPlayerProgress() {
        // player
        if let playerNode = childNode(withName: "playerNode") {
            player = Player(scene: self, name: "Фёдор", node: playerNode)
        } else {
            player = Player(scene: self, name: "Фёдор")
        }
    }
    
    func selectLastOpenedLevel() {
        self.player?.processedLevels.forEach({ (levelNum, completionStatus) in
            if completionStatus == "opened" {
                selectSpriteCell(num: levelNum)
            }
        })
    }
    
    func selectSpriteCell(num: Int) {
        if let selectedLevelSpriteCell = rightSide?.childNode(withName: "Level_\(num)_Sprite") as? SKSpriteNode {
            selectLevel(spriteCell: selectedLevelSpriteCell)
        } else {
            if let selectedLevelSpriteCell = rightSide?.childNode(withName: "Level_1_Sprite") as? SKSpriteNode {
                selectLevel(spriteCell: selectedLevelSpriteCell)
            }
        }
    }
    
    func fillLevelListSpriteCells() {
        var levelSpriteCell: SKSpriteNode?
        var connectionSprite: SKSpriteNode?
        var levelNumLabel: SKLabelNode?
        var subtextLabel: SKLabelNode?
        var levelCompletedMarkSprite: SKSpriteNode?
        var levelLockedSprite: SKSpriteNode?
        
        var runFist = true
        var prevPos: CGPoint?
        
        for level in levelList {
            
            if runFist {
                runFist = false
                levelSpriteCell = rightSide?.childNode(withName: "Level_1_Sprite") as? SKSpriteNode
                levelSpriteCell?.size = CGSize(width: (rightSide?.size.width)!, height: 80)
                levelSpriteCell?.anchorPoint = CGPoint(x: 0, y: 0)
                levelSpriteCell?.position = CGPoint(x: 0, y: 0)
                prevPos = levelSpriteCell?.position
                
       
                connectionSprite = levelSpriteCell?.childNode(withName: "ConnectionSprite") as? SKSpriteNode
                connectionSprite?.position = CGPoint(x: 0, y: (levelSpriteCell?.frame.height)! / 2)
                
            }
            else {
                levelSpriteCell = levelSpriteCell?.copy() as? SKSpriteNode
                levelSpriteCell?.name = "Level_\(level.number)_Sprite"
                levelSpriteCell?.childNode(withName: "ConnectionSprite")?.alpha = 0
                levelSpriteCell?.alpha = 0.74
                levelSpriteCell?.position = CGPoint(x: 0, y: prevPos!.y + (levelSpriteCell?.frame.height)! + 1)
                prevPos = levelSpriteCell?.position
                rightSide?.addChild(levelSpriteCell!)
            }
            
            levelNumLabel = levelSpriteCell?.childNode(withName: "LevelNumLabel") as? SKLabelNode
            levelNumLabel?.text = level.numberAsString
            
            levelNumLabel?.horizontalAlignmentMode = .center
            levelNumLabel?.verticalAlignmentMode = .center
            levelNumLabel?.position = CGPoint(x: (levelSpriteCell?.frame.width)! / 2, y: (levelSpriteCell?.frame.height)! / 2)

            levelCompletedMarkSprite = levelSpriteCell?.childNode(withName: "lvl-completed-mark") as? SKSpriteNode
            levelCompletedMarkSprite?.position = CGPoint(x: (levelNumLabel?.frame.minX)! / 2, y: (levelSpriteCell?.frame.height)! / 2)
            levelLockedSprite = levelSpriteCell?.childNode(withName: "LevelLockedSprite") as? SKSpriteNode
            levelLockedSprite?.position = CGPoint(x: (levelNumLabel?.frame.minX)! / 2, y: (levelSpriteCell?.frame.height)! / 2)
            
            if player?.processedLevels[level.number] == "completed" {
                levelCompletedMarkSprite?.alpha = 1
                levelLockedSprite?.alpha = 0
            } else if player?.processedLevels[level.number] == "opened" {
                levelCompletedMarkSprite?.alpha = 0
                levelLockedSprite?.alpha = 0
            }
            else {
                levelCompletedMarkSprite?.alpha = 0
                levelLockedSprite?.alpha = 1
                
            }
            
            subtextLabel = levelSpriteCell?.childNode(withName: "SubtextLabel") as? SKLabelNode
            subtextLabel?.text = level.mainHeader
            subtextLabel?.verticalAlignmentMode = .bottom
            subtextLabel?.horizontalAlignmentMode = .center
            subtextLabel?.position = CGPoint(x: (levelSpriteCell?.frame.width)! / 2 + 62, y: (levelNumLabel?.position.y)! - 36)
            
        }
    }
    
    func fillCurrSelectedLevelDescription() {
        //sprite cells setup
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
        
        // main header (name of level)
        mainHeader?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (leftSide?.frame.height)! - 35)
        mainHeader?.verticalAlignmentMode = .center
        mainHeader?.horizontalAlignmentMode = .center
        
        // reputation needed for entering to current selected level label
        reputationNeededLabel?.verticalAlignmentMode = .center
        reputationNeededLabel?.horizontalAlignmentMode = .center
        reputationNeededLabel?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (mainHeader?.position.y)! - (mainHeader?.frame.height)! )
        
        // minimap (image) of current selected level
        levelPic?.anchorPoint = CGPoint(x: 0.5, y: 1)
        levelPic?.size = CGSize(width: (leftSide?.frame.height)! / 2.6, height: (leftSide?.frame.height)! / 2.6 )
        levelPic?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (reputationNeededLabel?.position.y)! - ((reputationNeededLabel?.frame.height)!))
        
        // short description of current selected level
        levelDescSprite?.size = CGSize(width: displayWidth! / 2 - 20, height: (levelDescLabel?.frame.height)! + 20)
        levelDescSprite?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (levelPic?.position.y)! - ((levelPic?.frame.height)! + 40))
        
        levelDescLabel?.horizontalAlignmentMode = .center
        levelDescLabel?.verticalAlignmentMode = .center
        levelDescLabel?.preferredMaxLayoutWidth = displayWidth! * 2
        levelDescLabel?.position = CGPoint(x: 0, y: 0)

        // start playing current selected level button
        startButton?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        startButton?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (levelDescSprite?.position.y)! - ((levelDescSprite?.frame.height)! + 10))
        
    }
    
    func fillLevelDescription(selectedLvlNum: Int) {
        
        let currLevel = levelList[selectedLvlNum - 1]
        
        mainHeader?.text = currLevel.mainHeader
        
        let reputationForEnter = currLevel.reputationForEnter
        reputationNeededLabel?.text = "Репутация входа: \(reputationForEnter) (Ваша \(player!.reputation))"
        
        // reputation label color
        if reputationForEnter > player!.reputation {
            reputationNeededLabel?.fontColor = .red
            startButton?.color = .darkGray
            let btnLabel = startButton?.childNode(withName: "ButtonText") as? SKLabelNode
            btnLabel?.text = "Закрыто"
        } else {
            reputationNeededLabel?.fontColor = UIColor(named: Colors.ReputationNeededGreen.rawValue)
            startButton?.color = UIColor(named: Colors.PlayButtonNormal.rawValue)!
            let btnLabel = startButton?.childNode(withName: "ButtonText") as? SKLabelNode
            btnLabel?.text = "Играть"
        }
       
        if UIImage(named: "level\(selectedLvlNum)_minimap") != nil {
            levelPic?.texture = SKTexture(imageNamed: "level\(selectedLvlNum)_minimap")
        }
        
        levelDescLabel?.text = currLevel.shortDescription
        
        // run forever animation of start level button
        animateStartButton()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    override func setupInitialGameValues() {
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
        
        // sprites setup
        leftSide = childNode(withName: "LeftSideSprite") as? SKSpriteNode
        rightSide = childNode(withName: "RightSideSprite") as? SKSpriteNode
        
        let effectNode = SKEffectNode()
        leftSide?.removeFromParent()
        effectNode.addChild(leftSide!)
        leftSide?.blendMode = .add
        self.addChild(effectNode)
        
        leftSideWithEffect = effectNode
        
        // labels setup
        mainHeader = leftSide?.childNode(withName: "MainHeader") as? SKLabelNode
        reputationNeededLabel = leftSide?.childNode(withName: "ReputationNeededLabel") as? SKLabelNode
        levelPic = leftSide?.childNode(withName: "LevelPicture") as? SKSpriteNode
        levelDescSprite = leftSide?.childNode(withName: "DescriptionSprite") as? SKSpriteNode
        levelDescLabel = levelDescSprite?.childNode(withName: "LevelDescription") as? SKLabelNode
        startButton = leftSide?.childNode(withName: "StartButton") as? SKSpriteNode
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // buttons pressed check
            let touchedNode = atPoint(location)

            let nodeName = touchedNode.name
   
            if nodeName == "LevelNumLabel" || nodeName == "SubtextLabel" {
                if let selectedCellSprite = touchedNode.parent {
                    selectLevel(spriteCell: selectedCellSprite)
                }

            }  else if nodeName?.split(separator: "_")[0] == "Level" && nodeName?.split(separator: "_")[2] == "Sprite" {
                selectLevel(spriteCell: touchedNode)
                
            } else if nodeName == "StartButton" || nodeName == "StartButtonText" {
                run(MenuSounds.button_click.action)
                let animationNode = nodeName == "StartButton" ? touchedNode : touchedNode.parent
                animationNode?.run(.scale(to: 1.1, duration: 0.1)) {
                    touchedNode.run(.scale(to: 1.0, duration: 0.1))
                    self.startLevel(num: self.currSelectedLevel!)
                }
            }

        }
    }
    
    func selectLevel(spriteCell: SKNode) {
        
        var currSelectedLevelSprite: SKSpriteNode?
        
        run(MenuSounds.button_click.action)
        
        deselectAllCells()
        
        if let selectedLvlNum = Int((spriteCell.name!.split(separator: "_")[1])) {
            // fill left side of screen with level description
            fillLevelDescription(selectedLvlNum: selectedLvlNum)
            
            // select node
            currSelectedLevelSprite = spriteCell as? SKSpriteNode
            currSelectedLevel = selectedLvlNum
        }

        let connectionSprite = spriteCell.childNode(withName: "ConnectionSprite") as? SKSpriteNode
        connectionSprite?.alpha = 1
        
        let levelLokedSprite = spriteCell.childNode(withName: "LevelLockedSprite") as? SKSpriteNode
        
        currSelectedLevelSprite?.alpha = 1
        
        currSelectedLevelSprite?.run(.scale(to: 1.1, duration: 0.1))
        
        // blur animation effect
        let blurFilter = CIFilter(name: "CIBoxBlur",
                                  parameters: ["inputRadius": 30])
        leftSideWithEffect?.filter = blurFilter
        leftSideWithEffect?.blendMode = .multiply
        
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            currSelectedLevelSprite?.run(.scale(to: 1.0, duration: 0.1))
            self.leftSideWithEffect?.filter = nil
            self.leftSideWithEffect?.blendMode = .alpha
            levelLokedSprite?.run(.rotate(toAngle: 14 * (Double.pi / 180), duration: 0.1))
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                levelLokedSprite?.run(.rotate(toAngle: -14 * (Double.pi / 180), duration: 0.1))
            }
        }
    }
    
    func deselectAllCells() {
        rightSide?.children.forEach({ levelSpriteCell in
            levelSpriteCell.alpha = 0.74
            let cellConnectionSprite = levelSpriteCell.childNode(withName: "ConnectionSprite") as? SKSpriteNode
            cellConnectionSprite?.alpha = 0
        })
    }
    
    func animateStartButton() {
        startButton?.run(SKAction.repeatForever(.sequence([SKAction.fadeAlpha(to: 0.6, duration: 2.0), SKAction.fadeAlpha(to: 1.0, duration: 2.0)])))
        startButton?.run(SKAction.repeatForever(.sequence([SKAction.scale(to: 1.05, duration: 1.0), SKAction.scale(to: 1.0, duration: 0.6)])))
    }
    
    func startLevel(num: Int) {

        let levelScene = SKScene(fileNamed: "Level\(num)Scene")
        let transition = SKTransition.fade(with: .black, duration: 1.0)
        let displaySize: CGRect = UIScreen.main.bounds
        // Set the scale mode to scale to fit the window
        levelScene?.scaleMode = .aspectFill
        levelScene?.size = displaySize.size
        self.view?.presentScene(levelScene!, transition: transition)
    }
    
}
