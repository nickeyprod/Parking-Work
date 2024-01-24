//
//  Mission2.swift
//  Parking Work
//
//  Created by Николай Ногин on 10.07.2023.
//

import Foundation

import SpriteKit
import GameplayKit


class Mission2: ParkingWorkGame {
    
    var ChowerlerCar: Car? = nil
    var PosblancCar: Car? = nil
    var OldCopperCar: Car? = nil
    var playerPickedUpCigarette: Bool = false
    var vladik: SKNode? = nil
    var vladikStateMachine: GKStateMachine? = nil

    lazy var cigaretteFire: SKSpriteNode? = {
        return childNode(withName: "cigarette-fire") as? SKSpriteNode
    }()
    
    lazy var cigaretteItemEmitter: SKEmitterNode? = {
        guard let node = childNode(withName: "cigarette-fire") as? SKSpriteNode else { return nil }
        let ref = node.childNode(withName: "item-reference") as? SKReferenceNode
        return (ref?.children[0] as? SKEmitterNode)!
    }()
    
    // Old Copper Emitters
    lazy var OldCopperWindowSmokeEmitter: SKEmitterNode? = {
        guard let oldCopperNode = childNode(withName: CAR_TEXTURE_NAMES.oldCopper) as? SKSpriteNode else { return nil }
        let ref = oldCopperNode.childNode(withName: "smoke-from-window") as? SKReferenceNode
        return (ref?.children[0] as? SKEmitterNode)!
    }()

    lazy var OldCopperWindowFireEmitter: SKEmitterNode? = {
        guard let oldCopperNode = childNode(withName: CAR_TEXTURE_NAMES.oldCopper) as? SKSpriteNode else { return nil }
        let ref = oldCopperNode.childNode(withName: "fire-from-window") as? SKReferenceNode
        return (ref?.children[0] as? SKEmitterNode)!
    }()
    
    lazy var OldCopperMainSmokeEmitter: SKEmitterNode? = {
        guard let oldCopperNode = childNode(withName: CAR_TEXTURE_NAMES.oldCopper) as? SKSpriteNode else { return nil }
        let ref = oldCopperNode.childNode(withName: "main-smoke") as? SKReferenceNode
        return (ref?.children[0] as? SKEmitterNode)!
    }()
    
    lazy var OldCopperMainFireEmitter: SKEmitterNode? = {
        guard let oldCopperNode = childNode(withName: CAR_TEXTURE_NAMES.oldCopper) as? SKSpriteNode else { return nil }
        let ref = oldCopperNode.childNode(withName: "main-fire") as? SKReferenceNode
        return (ref?.children[0] as? SKEmitterNode)!
    }()
    
    var doorRinged: Bool = false
    
    var subtitlesSquare: SKSpriteNode? = nil
    var subtitlesLabel: SKLabelNode? = nil
    var vladikCrashInstructionsMessage: SKSpriteNode? = nil
    var vladikCrashInstructionsMessageLabel: SKLabelNode? = nil
    var vladikSpeakingSquare: SKSpriteNode? = nil
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
//        clearGameDatabase()
        
        // set mission number
        self.missionNum = 2
        self.canMoveCamera = true
        self.tutorialEnded = true
        
        // setup all physic bodies of the mission
        setupPhysicBodies()
        
        // setup emitters
        setupEmitters()
        
        // setup all needed initial variables (values)
        setupInitialGameValues()

        // setup camera of the mission
        setupCamera()
        
        // create menu screen
        createMenuScreen()
        
        // create mission task screen
        createMissionTaskScreen(taskMessage: "В этом районе живет Владик, Вам нужно напомнить ему про долг вашему Боссу. Босс: \(UNICODE.leftChevrone)Придумай что-нибудь, запугай его, но не убивай! И шепни ему на ушко мое имя, может вспомнит...\(UNICODE.rightChevrone)")
        
        // create Inventory screen
        createPlayerInventoryScreen()
        
        // create UI Buttons - pause, task buttons
        createUIButtons()
        
        // create window messages sprites
        createActionMessage()
        createOpenCarSuccessMessage()
        
        // setup chat window for messages
        setupChatWindow()
        
        // create anxiety bar
        createAnxietyBar()
        
        // create mini map
        createMinimap()
        
        // setup crosswalk
        setupCrosswalk()
        
//        runVladikDoorRingSubtitles()
//        runVladikCarCrashInstructions()
        
        // add cars dots to map
//        setupCarsOnMap()
        
        // setup pop-up windows (attach to global variables)
//        setupPopUpWindowMessages()
    
        // enter to initial player state
        playerStateMachine.enter(IdleState.self)
        
        // showing mission number at the start
        showBannerLabel(text: "Миссия \(missionNum)")
        
        // zoom out animation
        zoomOutInCameraAnimation(to: maxScale)
    
        // create target square for selected car
        createTargetWindow()
        
        pushMessageToChat(text: "Добро пожаловать на \(missionNum) миссию.")
        self.pushMessageToChat(text: "Приветствуем в районе Зеленой Аллеи города Сероветска.")
        
//        Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 26...48)), repeats: false) { _ in
//            self.pushMessageToChat(text: "Босс хочет, чтобы вы потренировались на этой парковке и угнали для него машину, марка не важна.")
//        }
        
        // fill items on this mission
//        fillItemsOfMission()
        
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
        
        // setup Vladik
        setupVladik()
        
        // setup all car locks
//        setupLocksForAllCars()

        
        // setup sounds
//        setupSounds()
        
        // setupTrashBaks
        setupTrashBaks()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            
            let location = touch.location(in: self)
            
            // buttons pressed check
            let touchedNode = atPoint(location)
            
            if (touchedNode.buttonType == .ActionYesButton) && !isUILocked {
                
                // off opening car when tutorial message is opened
                if !canMoveCamera { return }
                
                touchedNode.buttonShape.run(.scale(to: 1.1, duration: 0.2), completion: {
                    touchedNode.buttonShape.run(.scale(to: 1.0, duration: 0.1))
                    if self.actionMessageType == .DoorRingAction {
                        self.hideActionMessage()
                        
                        // run door bell sound positional
                        let doorBellSound = Sound.door_bell.audio
                        doorBellSound.autoplayLooped = false
                        
                        if let doorActionSprite = self.childNode(withName: "door-action") as? SKSpriteNode {
                            doorActionSprite.addChild(doorBellSound)
                            doorBellSound.run(.play())
                        }
                        
                        self.pushMessageToChat(text: "Вы звоните в дверь... ")
                        self.runVladikDoorRingSubtitles()
                       
                    } else if self.actionMessageType == .fireOldCopperWindow {
                        
                        self.player?.currTargetCar = self.OldCopperCar
                        self.showTargetWindow(with: (self.player?.currTargetCar)!)
                        
                        self.hideActionMessage()
                    
                        self.pushMessageToChat(text: "Вы сломали пассажирское стекло и закнули туда тлеющую сигарету!")
                        self.pushMessageToChat(text: "Скорее убирайтесь!")
                        
                        if let cigarette = self.cigaretteFire?.userData?.value(forKeyPath: "self") as? GameItem {
                            self.removeItemFromInventory(itemToRemove: cigarette)
                        }
                        
                        
                        // remove action sprite
                        if let actionSquare = self.OldCopperCar?.node?.childNode(withName: "fire-window-action-sprite") as? SKSpriteNode {
                            
                            let texture = SKTexture(imageNamed: "OldCopper_glass_broken")
                            
                            self.OldCopperCar?.node?.texture = texture
                            
                            // run glass breaking sound
                            let glassBreaking = Sound.breaking_glass.audio
                            glassBreaking.autoplayLooped = false
                            
                            self.OldCopperCar?.node?.addChild(glassBreaking)
                            glassBreaking.run(.play())
                            
                            actionSquare.removeAllActions()
                            actionSquare.removeFromParent()
                        }
                        
                        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { _ in
                            self.blowOldCopper()
                        }
                    }
                })
                
                run(MenuSounds.button_click.action)
            }
            else if (touchedNode.name == "ui-confirm-button" || touchedNode.name == "ui-confirm-label") {
                var btn: SKSpriteNode? = nil
                if touchedNode.name == "ui-confirm-button" {
                    btn = touchedNode as? SKSpriteNode
                } else {
                    btn = touchedNode.parent as? SKSpriteNode
                }
                run(MenuSounds.button_click.action)
                animateButtonClick(button: btn!) {
                    self.vladikCrashInstructionsMessage?.alpha = 0
                }
                
            }
            
        }

    }
    
    func checkPlayerPickedUpCigarette() {
        if playerPickedUpCigarette == true { return }
        
        for item in player!.inventory {
            if item?.name == ITEMS_TYPES.AUXILLARIES.smolderingCigarette.name {
                playerPickedUpCigarette = true
                
                Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { _ in
                    self.vladikCrashInstructionsMessageLabel?.text = "Возможно, закинув этот бычок в салон его тачки, мы сможем вынудить Владика выйти из дома? Дело за тобой..."
                    self.vladikCrashInstructionsMessage?.alpha = 0.80
                    self.addActionSpriteToOldCopperWindow()
                    
                }
                
                return
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if player!.onCrosswalk {
            trackCars()
        }
        else {
            ChowerlerCar?.node?.isPaused = false
            PosblancCar?.node?.isPaused = false
        }
        
        //checking if cigarette is in player's inventory
        checkPlayerPickedUpCigarette()
        
        if (player!.currTargetCar?.node?.name == "OldCopper") {
            if playerInFirstCircle {
                raiseAnxiety(to: 0.4)
            } else if playerInSecondCircle {
                raiseAnxiety(to: 0.2)
            } else if playerInThirdCircle {
                raiseAnxiety(to: 0.1)
            }
            
        }
    
    }
    
    func addActionSpriteToOldCopperWindow() {
        if let actionSquare = OldCopperCar?.node?.childNode(withName: "fire-window-action-sprite") as? SKSpriteNode {
            actionSquare.alpha = 0.4
            
            let actionSequence: [SKAction] = [.scale(to: 1.65, duration: 0.7), .scale(to: 1.25, duration: 0.8)]
            
            actionSquare.run(.repeatForever(.sequence(actionSequence)))
            
            actionSquare.physicsBody = SKPhysicsBody(rectangleOf: actionSquare.size)
            actionSquare.physicsBody?.affectedByGravity = false
            actionSquare.physicsBody?.categoryBitMask = actionCategory
            actionSquare.physicsBody?.contactTestBitMask = playerCategory
            actionSquare.physicsBody?.collisionBitMask = 0
            
        }
        
    }
    
    func trackCars() {
        if ChowerlerCar!.node!.isPaused {
            if ((PosblancCar?.node?.position.x)! >= -50 && (PosblancCar?.node?.position.x)! <= 50) && ((PosblancCar?.node!.position.y)! < 50 && (PosblancCar?.node!.position.y)! > -150) {
                PosblancCar?.node?.isPaused = true
                let audio = PosblancCar?.node?.childNode(withName: "driving-sound") as? SKAudioNode
                audio?.removeFromParent()
            }
        }
        
        if ChowerlerCar!.node!.isPaused {
            if ((PosblancCar?.node?.position.x)! <= -1850 && (PosblancCar?.node?.position.x)! >= -1700) && ((PosblancCar?.node!.position.y)! <= -300 && (PosblancCar?.node!.position.y)! >= -500) {
                PosblancCar?.node?.isPaused = true
                let audio = PosblancCar?.node?.childNode(withName: "driving-sound") as? SKAudioNode
                audio?.removeFromParent()
            }
        }
        
        if PosblancCar!.node!.isPaused {
            if ((ChowerlerCar?.node?.position.x)! >= -50 && (ChowerlerCar?.node?.position.x)! <= 50) && ((ChowerlerCar?.node!.position.y)! < 50 && (ChowerlerCar?.node!.position.y)! > -150) {
                ChowerlerCar?.node?.isPaused = true
                let audio = PosblancCar?.node?.childNode(withName: "driving-sound") as? SKAudioNode
                audio?.removeFromParent()
            }
        }
        
        if PosblancCar!.node!.isPaused {
            if ((ChowerlerCar?.node?.position.x)! <= -1850 && (ChowerlerCar?.node?.position.x)! >= -1700) && ((ChowerlerCar?.node!.position.y)! <= -300 && (ChowerlerCar?.node!.position.y)! >= -500) {
                ChowerlerCar?.node?.isPaused = true
                let audio = PosblancCar?.node?.childNode(withName: "driving-sound") as? SKAudioNode
                audio?.removeFromParent()
            }
            
        }
        
            
        // car is on the right of the crosswalk
        if ((ChowerlerCar?.node?.position.x)! >= 430 && (ChowerlerCar?.node?.position.x)! <= 530) && ((ChowerlerCar?.node!.position.y)! < 50 && (ChowerlerCar?.node!.position.y)! > -150) {
            ChowerlerCar?.node?.isPaused = true
            let audio = ChowerlerCar?.node?.childNode(withName: "driving-sound") as? SKAudioNode
            audio?.removeFromParent()
       
        }
        if ((PosblancCar?.node?.position.x)! >= 430 && (PosblancCar?.node?.position.x)! <= 530) && ((PosblancCar?.node!.position.y)! < 50 && (PosblancCar?.node!.position.y)! > -150) {
            PosblancCar?.node?.isPaused = true
            let audio = PosblancCar?.node?.childNode(withName: "driving-sound") as? SKAudioNode
            audio?.removeFromParent()
        }
        
        if ((ChowerlerCar?.node!.position.x)! <= 1400 && (ChowerlerCar?.node?.position.x)! >= 1240) && ((ChowerlerCar?.node!.position.y)! <= -300 && (ChowerlerCar?.node!.position.y)! >= -500)  {
            ChowerlerCar?.node?.isPaused = true
            let audio = ChowerlerCar?.node?.childNode(withName: "driving-sound") as? SKAudioNode
            audio?.removeFromParent()
 
        }
        if ((PosblancCar?.node!.position.x)! <= 1400 && (PosblancCar?.node?.position.x)! >= 1240) && ((PosblancCar?.node!.position.y)! <= -300 && (PosblancCar?.node!.position.y)! >= -500) {
            PosblancCar?.node?.isPaused = true
            let audio = PosblancCar?.node?.childNode(withName: "driving-sound") as? SKAudioNode
            audio?.removeFromParent()
            
        }
    }

    
}


// Collisions Processing
extension Mission2 {
    
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
//                print("didBeginContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
        
        let contactMask = getContactMask(contact.bodyA, contact.bodyB)
        
        switch contactMask {
        case (playerCategory | actionCategory):
            var actionName: String? = nil
            if contact.bodyA.node?.name != "playerNode" {
                actionName = contact.bodyA.node?.name
            }
            if contact.bodyB.node?.name != "playerNode" {
                actionName = contact.bodyB.node?.name
            }
            
            if actionName == "door-action" {
                // door ring action
                switchActionMessageType(to: .DoorRingAction)
            } else if actionName == "fire-window-action-sprite" {
                switchActionMessageType(to: .fireOldCopperWindow)
            }

            
            showActionMessage()
    
            
        case (playerCategory | carCategory):
            // bump can only cars that riding on the road
            if (contact.bodyB.node?.name == "Chowerler" || contact.bodyA.node?.name == "Chowerler") || (contact.bodyB.node?.name == "Posblanc" || contact.bodyA.node?.name == "Posblanc") {
                
                // player bumped by car
                if !carBumpedVar {
                    carBumpedVar = true
                    canRotate = false
                    player?.destinationPosition = player?.node?.position
                    player?.node?.run(.scale(to: 1.6, duration: 0.2) )
                
                    run(CarCollisionSounds.brake_bump.action)
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                        self.carBumped()
                    }
                }
            }
        case (playerCategory | speakingCategory):
            vladikSpeakingSquare?.physicsBody?.categoryBitMask = 0
            vladikSpeakingSquare?.physicsBody = nil
            vladikSpeakingSquare?.removeFromParent()
            
            self.runVladikScreamingSubtitles2()
            
            self.player?.node?.physicsBody?.pinned = true
            
        default:
            return
        }
    }
    
    override func didEnd(_ contact: SKPhysicsContact) {
        super.didEnd(contact)
        
        let contactMask = getContactMask(contact.bodyA, contact.bodyB)
        
        //        print("didEndContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
        
        switch contactMask {
        case (playerCategory | actionCategory):
            hideActionMessage()
        default:
            return
        }
    }
}
