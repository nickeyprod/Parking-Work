//
//  MissionList.swift
//  Parking Work
//
//  Created by Николай Ногин on 29.05.2023.
//

import SpriteKit

class MissionList: ParkingWorkGame {
    
    let missionList = [
        Mission(number: 1, mainHeader: "Привет, Босс", reputationForEnter: 0.0, shortDescription: "Парковка №17, р-н Чиперово, г. Сероветск."),
        Mission(number: 2, mainHeader: "Header 2", reputationForEnter: 6.0, shortDescription: "... Сообщение .... 2"),
        Mission(number: 3, mainHeader: "Header 3", reputationForEnter: 16.0, shortDescription: "... Сообщение .... 3"),
        Mission(number: 4, mainHeader: "Header 4", reputationForEnter: 19.0, shortDescription: "... Сообщение .... 4"),
        Mission(number: 5, mainHeader: "Header 5", reputationForEnter: 22.0, shortDescription: "... Сообщение .... 5")
    ]
    
    // sprite nodes
    var leftSide: SKSpriteNode?
    var leftSideWithEffect: SKEffectNode?
    var rightSide: SKSpriteNode?
    var missionPic: SKSpriteNode?
    var missionDescSprite: SKSpriteNode?
    var startButton: SKSpriteNode?
    
    // items panel
    var itemsPanel: SKSpriteNode?
    var shopLabel: SKLabelNode?
    var shopButton: SKSpriteNode?
    
    // current selected mission
    var currSelectedMission: Int?
    
    // missiom description (left pane)
    var mainHeader: SKLabelNode?
    var reputationNeededLabel: SKLabelNode?
    var missionPicture: SKLabelNode?
    var missionDescLabel: SKLabelNode?
    
    // sounds
    var backgroundSoundCars: SKAudioNode?

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // setup all needed variables
        setupInitialGameValues()
        
        // load player saved progess in the game
        loadPlayerProgress()
        
        // setup right pane (mission list cells)
        fillMissionListSpriteCells()
        
        // select last opened mission
        selectLastOpenedMission()
        
        // fill left pane (current selected mission description)
        fillCurrSelectedMissionDescription()
        
        // background sound
        backgroundSoundCars = MissionListSounds.mission_list_car_passing_by.audio
        addChild(backgroundSoundCars!)
    }
    
    func loadPlayerProgress() {
        // player
        if let playerNode = childNode(withName: "playerNode") {
            player = Player(scene: self, name: "Фёдор", node: playerNode)
        } else {
            player = Player(scene: self, name: "Фёдор")
        }
    }
    
    func selectLastOpenedMission() {
        self.player?.processedMissions.forEach({ (missionNum, completionStatus) in
            if completionStatus == "opened" {
                selectSpriteCell(num: missionNum)
            }
        })
    }
    
    func selectSpriteCell(num: Int) {
        if let selectedMissionSpriteCell = rightSide?.childNode(withName: "Mission_\(num)_Sprite") as? SKSpriteNode {
            selectMission(spriteCell: selectedMissionSpriteCell)
        } else {
            if let selectedMissionSpriteCell = rightSide?.childNode(withName: "Mission_1_Sprite") as? SKSpriteNode {
                selectMission(spriteCell: selectedMissionSpriteCell)
            }
        }
    }
    
    func fillMissionListSpriteCells() {
        var missionSpriteCell: SKSpriteNode?
        var connectionSprite: SKSpriteNode?
        var missionNumLabel: SKLabelNode?
        var subtextLabel: SKLabelNode?
        var missionCompletedMarkSprite: SKSpriteNode?
        var missionLockedSprite: SKSpriteNode?
        
        var runFist = true
        var prevPos: CGPoint?
        
        for mission in missionList {
            
            if runFist {
                runFist = false
                missionSpriteCell = rightSide?.childNode(withName: "Mission_1_Sprite") as? SKSpriteNode
                missionSpriteCell?.size = CGSize(width: (displayWidth! / 2) - 50, height: 80)
                missionSpriteCell?.anchorPoint = CGPoint(x: 0, y: 0)
                missionSpriteCell?.position = CGPoint(x: 0, y: 0)
                prevPos = missionSpriteCell?.position
                
       
                connectionSprite = missionSpriteCell?.childNode(withName: "ConnectionSprite") as? SKSpriteNode
                connectionSprite?.position = CGPoint(x: 0, y: (missionSpriteCell?.frame.height)! / 2)
                
            }
            else {
                missionSpriteCell = missionSpriteCell?.copy() as? SKSpriteNode
                missionSpriteCell?.name = "Mission_\(mission.number)_Sprite"
                missionSpriteCell?.childNode(withName: "ConnectionSprite")?.alpha = 0
                missionSpriteCell?.alpha = 0.74
                missionSpriteCell?.position = CGPoint(x: 0, y: prevPos!.y + (missionSpriteCell?.frame.height)! + 1)
                prevPos = missionSpriteCell?.position
                rightSide?.addChild(missionSpriteCell!)
            }
            
            missionNumLabel = missionSpriteCell?.childNode(withName: "MissionNumLabel") as? SKLabelNode
            missionNumLabel?.text = mission.numberAsString
            
            missionNumLabel?.horizontalAlignmentMode = .center
            missionNumLabel?.verticalAlignmentMode = .center
            missionNumLabel?.position = CGPoint(x: (missionSpriteCell?.frame.width)! / 2, y: (missionSpriteCell?.frame.height)! / 2)

            missionCompletedMarkSprite = missionSpriteCell?.childNode(withName: "mission-completed-mark") as? SKSpriteNode
            missionCompletedMarkSprite?.position = CGPoint(x: (missionNumLabel?.frame.minX)! / 2, y: (missionSpriteCell?.frame.height)! / 2)
            missionLockedSprite = missionSpriteCell?.childNode(withName: "MissionLockedSprite") as? SKSpriteNode
            missionLockedSprite?.position = CGPoint(x: (missionNumLabel?.frame.minX)! / 2, y: (missionSpriteCell?.frame.height)! / 2)
            
            if player?.processedMissions[mission.number] == "completed" {
                missionCompletedMarkSprite?.alpha = 1
                missionLockedSprite?.alpha = 0
            } else if player?.processedMissions[mission.number] == "opened" {
                missionCompletedMarkSprite?.alpha = 0
                missionLockedSprite?.alpha = 0
            }
            else {
                missionCompletedMarkSprite?.alpha = 0
                missionLockedSprite?.alpha = 1
                
            }
            
            subtextLabel = missionSpriteCell?.childNode(withName: "SubtextLabel") as? SKLabelNode
            subtextLabel?.text = mission.mainHeader
            subtextLabel?.verticalAlignmentMode = .bottom
            subtextLabel?.horizontalAlignmentMode = .center
            subtextLabel?.position = CGPoint(x: (missionSpriteCell?.frame.width)! / 2 + 62, y: (missionNumLabel?.position.y)! - 36)
            
        }
    }
    
    func fillCurrSelectedMissionDescription() {
        //left side setup - mission description

        // main header (name of mission)
        mainHeader?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (leftSide?.frame.height)! - 35)
        mainHeader?.verticalAlignmentMode = .center
        mainHeader?.horizontalAlignmentMode = .center
        
        // reputation needed for entering to current selected mission label
        reputationNeededLabel?.verticalAlignmentMode = .center
        reputationNeededLabel?.horizontalAlignmentMode = .center
        reputationNeededLabel?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (mainHeader?.position.y)! - (mainHeader?.frame.height)! )
        
        // minimap (image) of current selected mission
        missionPic?.anchorPoint = CGPoint(x: 0.5, y: 1)
        missionPic?.size = CGSize(width: (leftSide?.frame.height)! / 2.6, height: (leftSide?.frame.height)! / 2.6 )
        missionPic?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (reputationNeededLabel?.position.y)! - ((reputationNeededLabel?.frame.height)!))
        
        // short description of current selected mission
        missionDescSprite?.size = CGSize(width: displayWidth! / 2 - 20, height: (missionDescLabel?.frame.height)! + 20)
        missionDescSprite?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (missionPic?.position.y)! - ((missionPic?.frame.height)! + 40))
        
        missionDescLabel?.horizontalAlignmentMode = .center
        missionDescLabel?.verticalAlignmentMode = .center
        missionDescLabel?.preferredMaxLayoutWidth = displayWidth! * 2
        missionDescLabel?.position = CGPoint(x: 0, y: 0)

        // start playing current selected mission button
        startButton?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        startButton?.position = CGPoint(x: -(leftSide?.frame.width)! / 2, y: (missionDescSprite?.position.y)! - ((missionDescSprite?.frame.height)! + 10))
        
        itemsPanel?.size = CGSize(width: 50, height: displayHeight!)
        itemsPanel?.position = CGPoint(x: (rightSide?.frame.width)! + 25, y: (displayHeight! / 2))
        
        
    }
    
    func fillMissionDescription(selectedMissionNum: Int) {
        
        let currMission = missionList[selectedMissionNum - 1]
        
        mainHeader?.text = currMission.mainHeader
        
        let reputationForEnter = currMission.reputationForEnter
        reputationNeededLabel?.text = "Репутация входа: \(reputationForEnter) (Ваша \(player!.reputation))"
        
        
        let btnLabel = startButton?.childNode(withName: "StartButtonText") as? SKLabelNode
        
        // reputation label color
        if reputationForEnter > player!.reputation {
            reputationNeededLabel?.fontColor = .red
            startButton?.color = .darkGray
            btnLabel?.text = "Закрыто"
        } else {
            reputationNeededLabel?.fontColor = UIColor(named: COLORS.ReputationNeededGreen.rawValue)
            startButton?.color = UIColor(named: COLORS.PlayButtonNormal.rawValue)!
            btnLabel?.text = "Играть"
        }
       
        if UIImage(named: "mission\(selectedMissionNum)_minimap") != nil {
            missionPic?.texture = SKTexture(imageNamed: "mission\(selectedMissionNum)_minimap")
        }
        
        missionDescLabel?.text = currMission.shortDescription
        
        // run forever animation of start mission button
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
        
        // right side sprite
        rightSide?.size = CGSize(width: (displayWidth! / 2) - 50, height: displayHeight!)
        rightSide?.zRotation = 0
        rightSide?.anchorPoint = CGPoint(x: 0, y: 0)
        rightSide?.position = CGPoint(x: 1, y: (-displayHeight!) / 2)
        rightSide?.color = UIColor.clear
        
        // left side sprite
        leftSide?.size = CGSize(width: displayWidth! / 2, height: displayHeight!)
        leftSide?.zRotation = 0
        leftSide?.anchorPoint = CGPoint(x: 1, y: 0)
        leftSide?.position = CGPoint(x: 0, y: (-displayHeight! / 2))
        
        let effectNode = SKEffectNode()
        leftSide?.removeFromParent()
        effectNode.addChild(leftSide!)
        leftSide?.blendMode = .add
        self.addChild(effectNode)
        
        leftSideWithEffect = effectNode
        
        // labels setup
        mainHeader = leftSide?.childNode(withName: "MainHeader") as? SKLabelNode
        reputationNeededLabel = leftSide?.childNode(withName: "ReputationNeededLabel") as? SKLabelNode
        missionPic = leftSide?.childNode(withName: "MissionPicture") as? SKSpriteNode
        missionDescSprite = leftSide?.childNode(withName: "DescriptionSprite") as? SKSpriteNode
        missionDescLabel = missionDescSprite?.childNode(withName: "MissionDescription") as? SKLabelNode
        startButton = leftSide?.childNode(withName: "StartButton") as? SKSpriteNode
        
        itemsPanel = rightSide?.childNode(withName: "ItemsPanel") as? SKSpriteNode
        
        shopButton = itemsPanel?.childNode(withName: "ShopButton") as? SKSpriteNode
        
        shopLabel = itemsPanel?.childNode(withName: "ShopLabel") as? SKLabelNode
        shopLabel?.verticalAlignmentMode = .center
        shopLabel?.horizontalAlignmentMode = .center
        shopLabel?.position = CGPoint(x: (shopButton?.position.x)!, y: (shopButton?.position.y)! + 28)
        
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
   
            if nodeName == "MissionNumLabel" || nodeName == "SubtextLabel" {
                if let selectedCellSprite = touchedNode.parent {
                    selectMission(spriteCell: selectedCellSprite)
                }

            }  else if nodeName?.split(separator: "_")[0] == "Mission" && nodeName?.split(separator: "_")[2] == "Sprite" {
                selectMission(spriteCell: touchedNode)
                
            } else if nodeName == "StartButton" || nodeName == "StartButtonText" {
                run(MenuSounds.button_click.action)
                let animationNode = nodeName == "StartButton" ? touchedNode : touchedNode.parent
                animationNode?.run(.scale(to: 1.1, duration: 0.1)) {
                    touchedNode.run(.scale(to: 1.0, duration: 0.1))
                    self.startMission(num: self.currSelectedMission!)
                }
            } else if nodeName == "ShopButton" {
                run(MenuSounds.button_click.action)
                shopLabel?.run(.scale(to: 1.1, duration: 0.1))
                touchedNode.parent!.run(.scale(to: 1.1, duration: 0.1)) {
                    touchedNode.parent!.run(.scale(to: 1.0, duration: 0.1))
                    self.shopLabel?.run(.scale(to: 1.0, duration: 0.1))
                }
                print("Shop Open")
            }

        }
    }
    
    func selectMission(spriteCell: SKNode) {
        
        var currSelectedMissionSprite: SKSpriteNode?
        
        run(MenuSounds.button_click.action)
        
        deselectAllCells()
        
        if let selectedMissionNum = Int((spriteCell.name!.split(separator: "_")[1])) {
            // fill left side of screen with mission description
            fillMissionDescription(selectedMissionNum: selectedMissionNum)
            
            // select node
            currSelectedMissionSprite = spriteCell as? SKSpriteNode
            currSelectedMission = selectedMissionNum
        }

        let connectionSprite = spriteCell.childNode(withName: "ConnectionSprite") as? SKSpriteNode
        connectionSprite?.alpha = 1
        
        let missionLockedSprite = spriteCell.childNode(withName: "MissionLockedSprite") as? SKSpriteNode
        
        currSelectedMissionSprite?.alpha = 1
        
        currSelectedMissionSprite?.run(.scale(to: 1.1, duration: 0.1))
        // blur animation effect
        let blurFilter = CIFilter(name: "CIBoxBlur",
                                  parameters: ["inputRadius": 30])
        leftSideWithEffect?.filter = blurFilter
        leftSideWithEffect?.blendMode = .multiply

        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            currSelectedMissionSprite?.run(.scale(to: 1.0, duration: 0.1))
            self.leftSideWithEffect?.filter = nil
            self.leftSideWithEffect?.blendMode = .alpha
            missionLockedSprite?.run(.rotate(toAngle: 14 * (Double.pi / 180), duration: 0.1))
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                missionLockedSprite?.run(.rotate(toAngle: -14 * (Double.pi / 180), duration: 0.1))
            }
        }
    }
    
    func deselectAllCells() {
        rightSide?.children.forEach({ missionSpriteCell in
            missionSpriteCell.alpha = 0.74
            let cellConnectionSprite = missionSpriteCell.childNode(withName: "ConnectionSprite") as? SKSpriteNode
            cellConnectionSprite?.alpha = 0
        })
    }
    
    func animateStartButton() {
        startButton?.run(SKAction.repeatForever(.sequence([SKAction.fadeAlpha(to: 0.6, duration: 2.0), SKAction.fadeAlpha(to: 1.0, duration: 2.0)])))
        startButton?.run(SKAction.repeatForever(.sequence([SKAction.scale(to: 1.05, duration: 1.0), SKAction.scale(to: 1.0, duration: 0.6)])))
    }
    
    func startMission(num: Int) {
        if player?.processedMissions[num] == "completed" || player?.processedMissions[num] == "opened" {
            self.removeAllActions()
            backgroundSoundCars?.run(.stop())
            let missionScene = SKScene(fileNamed: "Mission\(num)Scene")
            let transition = SKTransition.fade(with: .black, duration: 1.0)
            let displaySize: CGRect = UIScreen.main.bounds
            // Set the scale mode to scale to fit the window
            missionScene?.scaleMode = .aspectFill
            missionScene?.size = displaySize.size
            self.view?.presentScene(missionScene!, transition: transition)
        }

    }
    
    deinit {
        print("deinit mission list")
    }
    
}
