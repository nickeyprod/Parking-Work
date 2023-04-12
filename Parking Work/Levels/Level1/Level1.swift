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
    
    var tutorialMsg = 1
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            
            let location = touch.location(in: self)
            
            // buttons pressed check
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "ui-next-label-btn" || touchedNode.name == "ui-next-btn" {
                if self.firstCarOpened == false {
                    self.nextTutorialMsg()
                } else {
                    self.tutorialMsg += 1
                    self.showCarLocksTutorial(tutorialMsg: self.tutorialMsg)
                }
                
                run(MenuSounds.button_click.action)
            }
        }

    }

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
    
        // create target square for selected car
        createSelectedTarget()
        
        // tutorial creating
        if restart == false {
            createTutorial()
        }
        
    
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
