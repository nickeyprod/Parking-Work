//
//  Policia.swift
//  Parking Work
//
//  Created by Николай Ногин on 21.07.2023.
//

import Foundation
import SpriteKit

extension ParkingWorkGame {
    
    // Initialize Policia
    func createPolicia(startEngine: Bool = false, hasBody: Bool = true) -> Car? {
        
        // Policia
        let policia = Car(
            scene: self,
            name: CAR_LIST.Policia.rawValue,
            initialSpeed: Policia.initialSpeed,
            maxSpeedForward: Policia.maxSpeedForward,
            maxSpeedBackward: Policia.maxSpeedBackward,
            turningSpeed: Policia.turningSpeed,
            accelerationRate: Policia.accelerationRate,
            secondaryAcceleration: Policia.secondaryAcceleration,
            brakeRate: Policia.brakeRate,
            smokeRate: Policia.smokeRate
        )
        
        guard let policiaNode = childNode(withName: CAR_TEXTURE_NAMES.policia) as? SKSpriteNode else {
            return nil
        }
        
        policia.node = policiaNode
        
        policiaNode.userData = NSMutableDictionary()
        policiaNode.userData?.setValue(policia.self, forKeyPath: "self")
        
        if hasBody {
            policiaNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.policia), size: policia.node!.size)
            
            policiaNode.physicsBody?.categoryBitMask = carCategory
            policiaNode.physicsBody?.collisionBitMask = boundaryCategory | carCategory | trashBakCategory
            policiaNode.physicsBody?.affectedByGravity = false
            policiaNode.physicsBody?.isDynamic = true
            policiaNode.physicsBody?.angularDamping = 3.4 // between 0.0 and 1.0
            policiaNode.physicsBody?.linearDamping = 12.0 // between 0.0 and 1.0
            policiaNode.physicsBody?.restitution = 0.01 // between 0.0 and 1.0
            policiaNode.physicsBody?.contactTestBitMask = boundaryCategory | carCategory | trashBakCategory
            
            policiaNode.physicsBody?.mass = 896
        }
        
        policiaNode.zPosition = 2
        policiaNode.anchorPoint = CGPoint(x: 0.49, y: 0.5)

        // policia engine smoke
        let refNode = policiaNode.childNode(withName: "smoke-emitter")
        policia.smokeEmitter = refNode?.children[0] as? SKEmitterNode

        if startEngine {
            policia.startEngine()
        } else {
            policia.stopEngine()
        }

        // Policia sounds
        // Engine start sound
        let engineStartSound = EngineSound.old_copper_engine_start.audio
        engineStartSound.name = EngineSound.old_copper_engine_start.rawValue
        engineStartSound.autoplayLooped = false
        policia.node?.addChild(engineStartSound)

        // Engine accelerating sound
        let engineAcceleratingSound = EngineSound.old_copper_acceleration.audio
        engineAcceleratingSound.name = EngineSound.old_copper_acceleration.rawValue
        engineAcceleratingSound.autoplayLooped = false
        policia.node?.addChild(engineAcceleratingSound)

        // Engine driving sound
        let engineDrivingSound = EngineSound.old_copper_driving.audio
        engineDrivingSound.name = EngineSound.old_copper_driving.rawValue
        engineDrivingSound.autoplayLooped = false
        policia.node?.addChild(engineDrivingSound)

        // Engine still sound
        let engineStillSound = EngineSound.old_copper_engine_still.audio
        engineStillSound.name = EngineSound.old_copper_engine_still.rawValue
        engineStillSound.autoplayLooped = false
        engineStillSound.isPositional = true
        policia.node?.addChild(engineStillSound)

        // Signalization sound
        let signalizationSound = Sound.car_signalization.audio
        signalizationSound.name = Sound.car_signalization.rawValue
        signalizationSound.autoplayLooped = false
        policia.node?.addChild(signalizationSound)

        // Door locked sound
        let doorLockedSound = Sound.car_door_locked.audio
        doorLockedSound.name = Sound.car_door_locked.rawValue
        doorLockedSound.autoplayLooped = false
        policia.node?.addChild(doorLockedSound)
        
        return policia

    }
}


