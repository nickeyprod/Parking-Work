//
//  GameSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit
import GameplayKit

// Game Start Setup 
extension ParkingWorkGame {
    
    // MARK: - Initial Game Values Setup
    /// Setup all initial values (or variables) needed for start the game
    func setupInitialGameValues() {
        playerLocationDestination = player?.position
        
        playerStateMachine = GKStateMachine(states: [
            WalkingState(player: player!),
            IdleState(player: player!)
        ])
    }
    
    // MARK: - Pop-up Windows Setup
    /// Setup of all pop-up window messages
    func setupPopUpWindowMessages() {
        // open car window message
        self.setupOpenCarWindowMessage()
        // open car window success message
        self.setupOpenCarSuccessWindowMessage()
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
