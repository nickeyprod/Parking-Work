//
//  PlayerStateMachine.swift
//  Parking Work
//
//  Created by Николай Ногин on 25.01.2023.
//

import GameplayKit

fileprivate let animationKey = "Sprite Animation"

class PlayerState: GKState {
    unowned var player: SKNode
    
    init(player: SKNode) {
        self.player = player
        
        super.init()
    }
}

class WalkingState: PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is WalkingState.Type:
            return false
        default:
            return true
        }
    }
    
    let textures: Array <SKTexture> = [
        SKTexture(imageNamed: "user_go_01"),
        SKTexture(imageNamed: "user_go_02"),
    ]
    

    lazy var walkAction = {
        SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.50))
    }()
    
    override func didEnter(from previousState: GKState?) {
        player.removeAction(forKey: animationKey)
        player.run(walkAction, withKey: animationKey)
    }
}


class RunningState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RunningState.Type:
            return false
        default:
            return true
        }
    }

    let textures: Array <SKTexture> = [
        SKTexture(imageNamed: "user_run_01"),
        SKTexture(imageNamed: "user_run_02"),
    ]

    lazy var runAction = {
        return SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.30))
    }()

    override func didEnter(from previousState: GKState?) {
        player.removeAction(forKey: animationKey)
        player.run(runAction, withKey: animationKey)
    }
}


class IdleState: PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdleState.Type:
            return false
        default:
            return true
        }
    }
    
    let textures: Array <SKTexture> = [
        SKTexture(imageNamed: "user_staying_00" ),
        SKTexture(imageNamed: "user_staying_01" )
    ]
    
    lazy var action = {
        SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.8))
    }()
    
    override func didEnter(from previousState: GKState?) {
        player.removeAction(forKey: animationKey)
        player.run(action, withKey: animationKey)
    }
}


