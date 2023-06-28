//
//  MissionCompletion.swift
//  Parking Work
//
//  Created by Николай Ногин on 25.05.2023.
//

import SpriteKit
import GameplayKit

class MissionCompletion: ParkingWorkGame {
    
    var moneyForMission: Float?
    var displayingMoney: Float = 0
    
    var reputationForMisson: Int?
    var displayingReputation: Int = 0
    
    var canAnimateMoney: Bool = false
    var canAnimateReputation: Bool = false
    
    var timeInterval: TimeInterval = 0.1
    
    // background sprite
    var backgroundSprite: SKSpriteNode?
    
    // main labels
    var missionCompletedLabel: SKLabelNode?
    var awardsLabel: SKLabelNode?
    
    // main nodes
    var reputationNode: SKSpriteNode?
    var moneyNode: SKSpriteNode?
    
    // buttons
    var nextButton: SKSpriteNode?
    
    // reputation labels
    var reputationStarSprite: SKSpriteNode?
    var reputationLabel: SKLabelNode?
    var reputationNum: SKLabelNode?
    
    // money labels
    var moneyWalletSprite: SKSpriteNode?
    var moneyLabel: SKLabelNode?
    var moneyNum: SKLabelNode?
    
    // button labels
    var nextBtnLabel: SKLabelNode?
    
    
    var initialMissionCompletedLabelPos: CGPoint?
    var initialAwardsLabelPos: CGPoint?
    var initialReputationNodePos: CGPoint?
    var initialMoneyNodePos: CGPoint?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // setup intial variables
        setupInitialGameValues()
        
        setupCompletionScreen()
        
        // animate background
        animateBackground()
        
        // animate screen
        animateMissionCompletedLabel()
    }
    
    override func setupInitialGameValues() {
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
        
        // background sprite
        backgroundSprite = childNode(withName: "completionBack") as? SKSpriteNode
        
        // nodes for reputation, money
        reputationNode = childNode(withName: "reputationNode") as? SKSpriteNode
        moneyNode = childNode(withName: "moneyNode") as? SKSpriteNode
        
        // labels
        missionCompletedLabel = childNode(withName: "missionCompletedLabel") as? SKLabelNode
        awardsLabel = childNode(withName: "awardsLabel") as? SKLabelNode
       
        // next button
        nextButton = childNode(withName: "ui-nextButton") as? SKSpriteNode
        
        // children of reputation node
        reputationStarSprite = reputationNode?.childNode(withName: "reputationStar") as? SKSpriteNode
        reputationLabel = reputationNode?.childNode(withName: "reputationLabel") as? SKLabelNode
        reputationNum = reputationNode?.childNode(withName: "reputationNum") as? SKLabelNode
        
        // children of money node
        moneyWalletSprite = moneyNode?.childNode(withName: "moneyWallet") as? SKSpriteNode
        moneyLabel = moneyNode?.childNode(withName: "moneyLabel") as? SKLabelNode
        moneyNum = moneyNode?.childNode(withName: "moneyNum") as? SKLabelNode
        
        // children of next button
        nextBtnLabel = nextButton?.childNode(withName: "ui-nextButtonLabel") as? SKLabelNode
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if canAnimateMoney && (displayingMoney < moneyForMission!) {
            self.animateMoneyDigits()
        }
        
        if canAnimateReputation && (displayingReputation < reputationForMisson!) {
            self.animateReputationDigits()
        }
        
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
            print("touch")
        }
    }
    
    func animateBackground() {
        backgroundSprite?.run(.scale(to: 1.1, duration: 1.8), completion: {
            self.backgroundSprite?.run(.repeatForever(
                .sequence([
                    .move(to: CGPoint(x: 24, y: 24), duration: 10.0),
                    .move(to: CGPoint(x: 10, y: 24), duration: 10.0),
                    .move(to: CGPoint(x: -24, y: -24), duration: 10.8)
                ])
            ))
        })
        
        
    }
    
    func setupCompletionScreen() {
        
        // setup mission completed label
        missionCompletedLabel?.text = "Миссия \(missionNum) завершена!"
        missionCompletedLabel?.verticalAlignmentMode = .top
        missionCompletedLabel?.position = CGPoint(x: 0, y: (displayHeight! / 2) - 20)
    
        // initial position for animation
        initialMissionCompletedLabelPos = missionCompletedLabel?.position

        // setup awards label
        awardsLabel?.verticalAlignmentMode = .top
        awardsLabel?.position = CGPoint(x: 0, y: (missionCompletedLabel?.position.y)! - (missionCompletedLabel?.frame.height)! - 30)
        initialAwardsLabelPos = awardsLabel?.position
        
        // setup reputation node
        reputationNode?.position = CGPoint(x: 0, y: (awardsLabel?.position.y)! - (awardsLabel?.frame.height)! - ((reputationNode?.frame.height)! / 2) - 30 )
        initialReputationNodePos = reputationNode?.position
        
        // setup money node
        moneyNode?.position = CGPoint(x: 0, y: (reputationNode?.position.y)! - (reputationNode?.frame.height)! / 2 - ((moneyNode?.frame.height)! / 2) - 20 )
        initialMoneyNodePos = moneyNode?.position
        
        // setup button
        nextButton?.position = CGPoint(x: 0, y: -(displayHeight! / 2) + (nextButton?.frame.height)! / 2 + 15)
        
    }
    
    func animateMissionCompletedLabel() {
        missionCompletedLabel?.setScale(0.1)
        missionCompletedLabel?.position.y = displayHeight! + 20
        
        awardsLabel?.setScale(0.1)
        awardsLabel?.position.y = displayHeight! + 20
        
        reputationNode?.setScale(0.1)
        reputationNode?.position.y = displayHeight! + 20
        
        moneyNode?.setScale(0.1)
        moneyNode?.position.y = displayHeight! + 20
        
        nextButton?.setScale(0)
        
        missionCompletedLabel?.run(.scale(to: 1.1, duration: 0.5), completion: {
            self.missionCompletedLabel?.run(.scale(to: 1.0, duration: 0.3))
        })
        
        missionCompletedLabel?.run(.move(to: initialMissionCompletedLabelPos!, duration: 0.4), completion: {
            self.animateAwardsLabel()
        })
    
    }
    
    func animateAwardsLabel() {
        awardsLabel?.run(.scale(to: 1.1, duration: 0.5), completion: {
            self.awardsLabel?.run(.scale(to: 1.0, duration: 0.3))
        })
        
        awardsLabel?.run(.move(to: initialAwardsLabelPos!, duration: 0.4), completion: {
            self.animateReputationNode()
        })
    }
    
    func animateReputationNode() {
        reputationNode?.run(.scale(to: 1.1, duration: 0.4), completion: {
            self.reputationNode?.run(.scale(to: 1.0, duration: 0.2))
        })
        
        reputationNode?.run(.move(to: initialReputationNodePos!, duration: 0.4), completion: {
            self.animateMoneyNode()
            self.canAnimateReputation = true
        })
        
        // animate star sprite
        reputationStarSprite?.run(
            .sequence([
                .rotate(toAngle: 0.4, duration: 0.4),
                .rotate(toAngle: 0, duration: 0.3),
                .rotate(toAngle: 0.4, duration: 0.4),
                .rotate(toAngle: 0, duration: 0.3)
            ]
        ))
        
        reputationStarSprite?.run(.scale(to: 1.1, duration: 0.8), completion: {
            self.reputationStarSprite?.run(.scale(to: 1.0, duration: 0.2))
        })
    }
    
    func animateMoneyNode() {
        moneyNode?.run(.scale(to: 1.1, duration: 0.4), completion: {
            self.moneyNode?.run(.scale(to: 1.0, duration: 0.2))
        })
        
        moneyNode?.run(.move(to: initialMoneyNodePos!, duration: 0.4), completion: { [self] in
            self.canAnimateMoney = true
            self.nextButton?.run(.scale(to: 1.2, duration: 0.2), completion: {
                self.animateStartButton(button: self.nextButton!)
            })
        })
        
        // animate wallet sprite
        
        moneyWalletSprite?.run(
            .sequence([
                .rotate(toAngle: 0.4, duration: 0.4),
                .rotate(toAngle: 0, duration: 0.3),
                .rotate(toAngle: 0.4, duration: 0.4),
                .rotate(toAngle: 0, duration: 0.3)
            ]
        ))
        
        moneyWalletSprite?.run(.scale(to: 1.1, duration: 0.8), completion: {
            self.moneyWalletSprite?.run(.scale(to: 1.0, duration: 0.2))
        
        })
    }
    
    func animateMoneyDigits() {
        let percent = (displayingMoney / moneyForMission!) * 100
        let a = 100 - percent
        
        displayingMoney += a
        moneyNum?.text = "\(String(format: "%.1f", displayingMoney))"
        
    }
        
    func animateReputationDigits() {
        displayingReputation += 1
        reputationNum?.text = "+\(displayingReputation)"
    }
}
