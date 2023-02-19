//
//  Level1.swift
//  Parking Work
//
//  Created by Николай Ногин on 19.02.2023.
//

import SpriteKit
import GameplayKit

class Level1: ParkingWorkGame {
    
    // Cars
    var oldCopper: SKNode?
    var chowerler: SKNode?

    enum Cars: String {
        case OldCopper
        case Chowerler
    }
    

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // setup all physic bodies of the level
        setupPhysicBodies()
        
        // setup all needed initial variables (values)
        setupInitialGameValues()
        
        // setup camera of the level
        setupCamera()
        
        // setup pop-up windows
        setupPopUpWindowMessages()
        
        // enter to initial player state
        playerStateMachine.enter(IdleState.self)
        
    }
    
    // MARK: - Physic Bodies Setup
    /// Setup of all game physic bodies
    func setupPhysicBodies() {
        
        // world bounds to collide
        setupWorldBoundaries()
        
        // player
        setupPlayer()
        
        // cars
        setupCars()
        
        // car locks
        setupCarLocks()
        
    }

}
