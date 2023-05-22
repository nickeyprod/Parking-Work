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
        
        // off tutorial
        self.tutorial(set: false)

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
        
        // setup chat window for messages
        setupChatWindow()
        
        // create anxiety bar
        createAnxietyBar()
        
        // create mini map
        createMinimap()
        
        // add cars dots to map
        setupCarsOnMap()
        
        // setup pop-up windows (attach to global variables)
        setupPopUpWindowMessages()
    
        // enter to initial player state
        playerStateMachine.enter(IdleState.self)
        
        // showing level number at the start
//        showBannerLabel(text: "Уровень \(levelNum)")
        
        // zoom out animation
//        zoomOutInCameraAnimation(to: maxScale)
    
        // create target square for selected car
        createSelectedTarget()
        
        // tutorial creating
        if restart == false {
            createTutorial()
        }
        
        pushMessageToChat(text: "Добро пожаловать на 1 уровень.")
        if tutorialEnded {
            self.pushMessageToChat(text: "Добро пожаловать! Парковка №17 в спальном районе Чиперово города Сероветска.")
            
            Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 26...48)), repeats: false) { _ in
                self.pushMessageToChat(text: "Босс хочет, чтобы вы потренировались на этой парковке и угнали для него машину, марка не важна.")
            }
        }
        
        self.player?.getIn(the: self.oldCopper!)
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
        
        // setup pigeouns to fly away
        setupPigeons()
        
        // setup sounds
        setupSounds()
        
        // setupTrashBaks
        setupTrashBaks()
        
        // setup level completion rules
        setupLevelCompletion()
        
    }

}
