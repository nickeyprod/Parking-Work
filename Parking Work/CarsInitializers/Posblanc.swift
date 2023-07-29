//
//  Posblanc.swift
//  Parking Work
//
//  Created by Николай Ногин on 21.07.2023.
//


import Foundation
import SpriteKit

extension ParkingWorkGame {
    
    // Initialize Posblanc
    func createPosblanc(startEngine: Bool = false, hasBody: Bool = true) -> Car? {
        
        // Posblanc
        let posblanc = Car(
           scene: self,
           name: CAR_LIST.Posblanc.rawValue,
           initialSpeed: Posblanc.initialSpeed,
           maxSpeedForward: Posblanc.maxSpeedForward,
           maxSpeedBackward: Posblanc.maxSpeedBackward,
           turningSpeed: Posblanc.turningSpeed,
           accelerationRate: Posblanc.accelerationRate,
           secondaryAcceleration: Posblanc.secondaryAcceleration,
           brakeRate: Posblanc.brakeRate,
           smokeRate: Posblanc.smokeRate
        )
        
        guard let posblancNode = childNode(withName: CAR_TEXTURE_NAMES.posblanc) as? SKSpriteNode else {
            return nil
        }
        
        posblanc.node = posblancNode
        
        posblancNode.userData = NSMutableDictionary()
        posblancNode.userData?.setValue(posblanc.self, forKeyPath: "self")
        
        if hasBody {
            posblancNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.posblanc), size: posblanc.node!.size)
            
            posblancNode.physicsBody?.categoryBitMask = carCategory
            posblancNode.physicsBody?.collisionBitMask = boundaryCategory | carCategory | trashBakCategory
            posblancNode.physicsBody?.affectedByGravity = false
            posblancNode.physicsBody?.isDynamic = true
            posblancNode.physicsBody?.angularDamping = 3.4 // between 0.0 and 1.0
            posblancNode.physicsBody?.linearDamping = 12.0 // between 0.0 and 1.0
            posblancNode.physicsBody?.restitution = 0.01 // between 0.0 and 1.0
            posblancNode.physicsBody?.contactTestBitMask = boundaryCategory | carCategory | trashBakCategory
            
            posblancNode.physicsBody?.mass = 896
        }
        
        posblancNode.zPosition = 2
        posblancNode.anchorPoint = CGPoint(x: 0.49, y: 0.5)

        // old copper engine smoke
        let refNode = posblancNode.childNode(withName: "smoke-emitter")
        posblanc.smokeEmitter = refNode?.children[0] as? SKEmitterNode
        
        if startEngine {
            posblanc.startEngine()
        } else {
            posblanc.stopEngine()
        }

        // Posblanc sounds
        // Engine start sound
        let engineStartSound = EngineSound.old_copper_engine_start.audio
        engineStartSound.name = EngineSound.old_copper_engine_start.rawValue
        engineStartSound.autoplayLooped = false
        posblanc.node?.addChild(engineStartSound)

        // Engine accelerating sound
        let engineAcceleratingSound = EngineSound.old_copper_acceleration.audio
        engineAcceleratingSound.name = EngineSound.old_copper_acceleration.rawValue
        engineAcceleratingSound.autoplayLooped = false
        posblanc.node?.addChild(engineAcceleratingSound)

        // Engine driving sound
        let engineDrivingSound = EngineSound.old_copper_driving.audio
        engineDrivingSound.name = EngineSound.old_copper_driving.rawValue
        engineDrivingSound.autoplayLooped = false
        posblanc.node?.addChild(engineDrivingSound)

        // Engine still sound
        let engineStillSound = EngineSound.old_copper_engine_still.audio
        engineStillSound.name = EngineSound.old_copper_engine_still.rawValue
        engineStillSound.autoplayLooped = false
        engineStillSound.isPositional = true
        posblanc.node?.addChild(engineStillSound)

        // Signalization sound
        let signalizationSound = Sound.car_signalization.audio
        signalizationSound.name = Sound.car_signalization.rawValue
        signalizationSound.autoplayLooped = false
        posblanc.node?.addChild(signalizationSound)

        // Door locked sound
        let doorLockedSound = Sound.car_door_locked.audio
        doorLockedSound.name = Sound.car_door_locked.rawValue
        doorLockedSound.autoplayLooped = false
        posblanc.node?.addChild(doorLockedSound)
        
        return posblanc

    }
}

