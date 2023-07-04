//
//  Mission1.swift
//  Parking Work
//
//  Created by Николай Ногин on 19.02.2023.
//

import SpriteKit
import GameplayKit


class Mission1: ParkingWorkGame {

    // Cars
    var carsOnLevel: [Car?] = []
    
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
        
        // set mission number
        self.missionNum = 1
        
        // setup all physic bodies of the mission
        setupPhysicBodies()
        
        // setup all needed initial variables (values)
        setupInitialGameValues()
        
        // off tutorial
        self.tutorial(set: false)

        // setup camera of the mission
        setupCamera()
        
        // create menu screen
        createMenuScreen()
        
        // create mission task screen
        createMissionTaskScreen()
        
        // create Inventory screen
        createPlayerInventoryScreen()
        
        // create UI Buttons - pause, task buttons
        createUIButtons()
        
        // create Icons (money/reputation)
        createIcons()
        
        // create window messages sprites
        createActionMessage()
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
        
        // showing mission number at the start
        showBannerLabel(text: "Миссия \(missionNum)")
        
        // zoom out animation
        zoomOutInCameraAnimation(to: maxScale)
    
        // create target square for selected car
        createTargetWindow()
        
        // tutorial creating
        if restart == false {
            createTutorial()
        }
        
        pushMessageToChat(text: "Добро пожаловать на 1 миссию.")
        if tutorialEnded {
            self.pushMessageToChat(text: "Добро пожаловать! Парковка №17 в спальном районе Чиперово города Сероветска.")
            
            Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 26...48)), repeats: false) { _ in
                self.pushMessageToChat(text: "Босс хочет, чтобы вы потренировались на этой парковке и угнали для него машину, марка не важна.")
            }
        }
//        self.player?.getIn(the: self.oldCopper!)
        
        
        // fill items on this mission
        fillItemsOfMission()

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
        
        // setup all car locks
        setupLocksForAllCars()
        
        // setup pigeouns to fly away
        setupPigeons()
        
        // setup sounds
        setupSounds()
        
        // setupTrashBaks
        setupTrashBaks()
        
        // setup mission completion rules
        setupMissionCompletion()
        
    }

}
