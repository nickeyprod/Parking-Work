//
//  M2VladikSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 26.07.2023.
//

import Foundation
import SpriteKit

import GameplayKit

fileprivate let animationKey = "Vladik Animation"

class VladikState: GKState {
    unowned var vladik: SKNode
    
    init(vladik: SKNode) {
        self.vladik = vladik
        
        super.init()
    }
}

class WalkingVladikState: VladikState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is WalkingState.Type:
            return false
        default:
            return true
        }
    }
    
    let textures: Array <SKTexture> = [
        SKTexture(imageNamed: "vladik_go_01"),
        SKTexture(imageNamed: "vladik_go_02")
    ]
    

    lazy var walkAction = {
        SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.5))
    }()
    
    override func didEnter(from previousState: GKState?) {
        vladik.removeAction(forKey: animationKey)
        vladik.run(walkAction, withKey: animationKey)
    }
}


class RunningVladikState: VladikState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RunningState.Type:
            return false
        default:
            return true
        }
    }

    let textures: Array <SKTexture> = [
        SKTexture(imageNamed: "vladik_run_01"),
        SKTexture(imageNamed: "vladik_run_02"),
    ]

    lazy var runAction = {
        return SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.5))
    }()

    override func didEnter(from previousState: GKState?) {
        vladik.removeAction(forKey: animationKey)
        vladik.run(runAction, withKey: animationKey)
    }
}


class IdleVladikState: VladikState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdleState.Type:
            return false
        default:
            return true
        }
    }
    
    let textures: Array <SKTexture> = [
        SKTexture(imageNamed: "vladik_staying_00" ),
        SKTexture(imageNamed: "vladik_staying_01" )
    ]
    
    lazy var action = {
        SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.8))
    }()
    
    override func didEnter(from previousState: GKState?) {
        vladik.removeAction(forKey: animationKey)
        vladik.run(action, withKey: animationKey)
    }
}




// Mission 2 Vladik Setup
extension Mission2 {
    
    func setupVladikSpeakingSquare() {
        vladikSpeakingSquare = vladik?.childNode(withName: "speakingSquare") as? SKSpriteNode
        vladikSpeakingSquare?.physicsBody = SKPhysicsBody(rectangleOf: vladikSpeakingSquare!.size)
        vladikSpeakingSquare?.physicsBody?.pinned = true
        vladikSpeakingSquare?.physicsBody?.affectedByGravity = false
        vladikSpeakingSquare?.physicsBody?.categoryBitMask = speakingCategory
        vladikSpeakingSquare?.physicsBody?.contactTestBitMask = playerCategory
        vladikSpeakingSquare?.color = .green
        vladikSpeakingSquare?.alpha = 0.4
        
        let actions = [SKAction.scale(to: 1.2, duration: 1.1), SKAction.scale(to: 1.0, duration: 1.0)]
        vladikSpeakingSquare?.run(.repeatForever(.sequence(actions)))
    }
    
    func setupVladikPhysicBody() {
        vladik?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "vladik_staying_01"), size: vladik!.frame.size)
        vladik?.physicsBody?.mass = 80
        vladik?.zPosition = 2
        vladik?.physicsBody?.affectedByGravity = false
        vladik?.physicsBody?.allowsRotation = false
        vladik?.physicsBody?.categoryBitMask = secondaryUnitCategory
        vladik?.physicsBody?.collisionBitMask = playerCategory | carCategory | boundaryCategory
    }
    
    func setupVladik() {
        
        // create Vladik State Machine for vladik animations
        if let vladikNode = self.childNode(withName: "Vladik") {
            
            vladik = vladikNode
            
            
            // intialize possible vladik's states
            vladikStateMachine = GKStateMachine(states: [
                WalkingVladikState(vladik: vladikNode),
                RunningVladikState(vladik: vladikNode),
                IdleVladikState(vladik: vladikNode)
            ])
        }
        
        let doorActionSprite = self.childNode(withName: "door-action") as? SKSpriteNode
        doorActionSprite?.physicsBody = SKPhysicsBody(rectangleOf: doorActionSprite!.size)
        doorActionSprite?.physicsBody?.affectedByGravity = false
        doorActionSprite?.physicsBody?.collisionBitMask = 0
        doorActionSprite?.physicsBody?.categoryBitMask = actionCategory
        doorActionSprite?.physicsBody?.contactTestBitMask = playerCategory
        
        //animate door action sprite
        let scaleArr: [SKAction] = [SKAction.scale(to: 1.2, duration: 1.2), SKAction.scale(to: 1.6, duration: 0.8)]
        doorActionSprite?.run(.repeatForever(SKAction.sequence(scaleArr)))
        
    }
    
    func vladikGoingBackHome() {
        self.player?.node?.physicsBody?.pinned = false
        self.vladik?.physicsBody?.pinned = false
        vladik?.physicsBody?.collisionBitMask = 0
        
        // vladik moves back home
        let rAction = SKAction.rotate(toAngle: 4.9449, duration: 0.5, shortestUnitArc: true)
        // vladik moves back home
        let rAction2 = SKAction.rotate(toAngle: 3.1449, duration: 0.8, shortestUnitArc: true)
        
        let moveAction1 = SKAction.move(to: CGPoint(x: 945, y: -858.0), duration: 4.8)
        let moveAction2 = SKAction.moveTo(y: -1150, duration: 2.5)
        
        vladik?.run(rAction, completion: {
            self.vladikStateMachine?.enter(WalkingVladikState.self)
            self.vladik?.run(moveAction1, completion: {
                self.vladikStateMachine?.enter(IdleVladikState.self)
                self.vladik?.run(rAction2, completion: {
                    self.vladikStateMachine?.enter(WalkingVladikState.self)
                    self.vladik?.run(moveAction2, completion: {
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                            self.runMissionCompletedScreen(money: MISSIONS.Mission2.Awards.money, reputation: MISSIONS.Mission2.Awards.reputation)
                        }
                    })
                })
            })
        })
        
    }
    
    func vladikGoingOutFromHome() {
        
        runVladikScreamingSubtitles1()
        
        // Vladik is runnig out of home!
        vladikStateMachine?.enter(RunningVladikState.self)

        // vladik moves from door
        let moveAction1 = SKAction.moveTo(y: -858.0, duration: 2.5)
        let moveAction2 = SKAction.move(to: CGPoint(x: 488.5, y: -934.48), duration: 4.4)
        let rAction = SKAction.rotate(toAngle: 1.7649, duration: 0.5, shortestUnitArc: true)
        let rAction2 = SKAction.rotate(toAngle: 2.1649, duration: 0.5, shortestUnitArc: true)
        vladik?.run(moveAction1, completion: {
            self.vladikStateMachine?.enter(IdleVladikState.self)
            
            self.setupVladikPhysicBody()
            
            self.vladik?.run(rAction)
            Timer.scheduledTimer(withTimeInterval: 2.3, repeats: false) { _ in
                self.vladikStateMachine?.enter(RunningVladikState.self)
                
                self.vladik?.run(moveAction2, completion: {
                    self.vladikStateMachine?.enter(IdleVladikState.self)
                    self.vladik?.run(rAction2)
                    self.vladik?.physicsBody?.pinned = true
                })
            }
        })

    }
}
