//
//  OldCopper.swift
//  Parking Work
//
//  Created by Николай Ногин on 21.07.2023.
//

import Foundation
import SpriteKit

extension ParkingWorkGame {
    
    // Initialize Old Copper
    func createOldCopper(startEngine: Bool = false, hasBody: Bool = true) -> Car? {
        
        let oldCopper = Car(
            scene: self,
            name: CAR_LIST.OldCopper.rawValue,
            initialSpeed: 4,
            maxSpeedForward: 150,
            maxSpeedBackward: 60,
            turningSpeed: 0.006,
            accelerationRate: 1,
            secondaryAcceleration: 0.01,
            brakeRate: 1.5,
            smokeRate: 10
        )

        guard let oldCopperNode = childNode(withName: CAR_TEXTURE_NAMES.oldCopper) as? SKSpriteNode else {
            return nil
        }
        
        oldCopper.node = oldCopperNode
        
        oldCopperNode.userData = NSMutableDictionary()
        oldCopperNode.userData?.setValue(oldCopper.self, forKeyPath: "self")
        if hasBody {
            oldCopperNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.oldCopper), size: oldCopper.node!.size)
            
            oldCopperNode.physicsBody?.categoryBitMask = carCategory
            oldCopperNode.physicsBody?.collisionBitMask = boundaryCategory | carCategory | trashBakCategory
            oldCopperNode.physicsBody?.affectedByGravity = false
            oldCopperNode.physicsBody?.isDynamic = true
            oldCopperNode.physicsBody?.angularDamping = 3.4 // between 0.0 and 1.0
            oldCopperNode.physicsBody?.linearDamping = 12.0 // between 0.0 and 1.0
            oldCopperNode.physicsBody?.restitution = 0.01 // between 0.0 and 1.0
            oldCopperNode.physicsBody?.contactTestBitMask = boundaryCategory | carCategory | trashBakCategory
            
            oldCopperNode.physicsBody?.mass = 896
        }
        oldCopperNode.zPosition = 2
        oldCopperNode.anchorPoint = CGPoint(x: 0.49, y: 0.5)

        // old copper engine smoke
        var refNode = oldCopperNode.childNode(withName: "smoke-emitter")
        oldCopper.smokeEmitter = refNode?.children[0] as? SKEmitterNode
        
        if startEngine {
            oldCopper.startEngine()
        } else {
            oldCopper.stopEngine()
        }

        // old copper sounds
        // Engine start sound
        let engineStartSound = EngineSound.old_copper_engine_start.audio
        engineStartSound.name = EngineSound.old_copper_engine_start.rawValue
        engineStartSound.autoplayLooped = false
        oldCopper.node?.addChild(engineStartSound)

        // Engine accelerating sound
        let engineAcceleratingSound = EngineSound.old_copper_acceleration.audio
        engineAcceleratingSound.name = EngineSound.old_copper_acceleration.rawValue
        engineAcceleratingSound.autoplayLooped = false
        oldCopper.node?.addChild(engineAcceleratingSound)

        // Engine driving sound
        let engineDrivingSound = EngineSound.old_copper_driving.audio
        engineDrivingSound.name = EngineSound.old_copper_driving.rawValue
        engineDrivingSound.autoplayLooped = false
        oldCopper.node?.addChild(engineDrivingSound)

        // Engine still sound
        let engineStillSound = EngineSound.old_copper_engine_still.audio
        engineStillSound.name = EngineSound.old_copper_engine_still.rawValue
        engineStillSound.autoplayLooped = false
        engineStillSound.isPositional = true
        oldCopper.node?.addChild(engineStillSound)

        // Signalization sound
        let signalizationSound = Sound.car_signalization.audio
        signalizationSound.name = Sound.car_signalization.rawValue
        signalizationSound.autoplayLooped = false
        oldCopper.node?.addChild(signalizationSound)

        // Door locked sound
        let doorLockedSound = Sound.car_door_locked.audio
        doorLockedSound.name = Sound.car_door_locked.rawValue
        doorLockedSound.autoplayLooped = false
        oldCopper.node?.addChild(doorLockedSound)
        
        return oldCopper

    }
}

