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
    var oldCopper: Car?
    var chowerler: Car?

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // set level number
        self.levelNum = 1
        
        // setup all physic bodies of the level
        setupPhysicBodies()
        
        // setup all needed initial variables (values)
        setupInitialGameValues()

        // setup camera of the level
        setupCamera()
        
        // create menu screen
        createMenuScreen()
        
        // create level task screen
        createLevelTaskScreen()
        
        // create UI Buttons - pause, task buttons
        createUIButtons()
        
        // create window messages sprites
        createOpenCarMessage()
        createOpenCarSuccessMessage()
        
        // create anxiety bar
        createAnxietyBar()
        
        // create mini map
        createMinimap()
        
        // add cars dots to map
        setupCarsOnMap()
        
        // setup pop-up windows (attach to global variables)
        setupPopUpWindowMessages()
        
        // play traffic street background sound
//        run(SKAction.sequence([
//            run(SKAction.repeatForever(CitySound.traffic1.action))
//            SKAction.changeVolume(to: 0.00, duration: 0)
//        ]))
        // enter to initial player state
        playerStateMachine.enter(IdleState.self)
        
        // showing level number at the start
        showLevelNumLabel()
        
        // zoom out animation
        zoomOutCamera(to: maxScale)
        
//        PlusMap()
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
