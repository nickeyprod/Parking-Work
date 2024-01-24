//
//  Chowerler.swift
//  Parking Work
//
//  Created by Николай Ногин on 21.07.2023.
//

import Foundation
import SpriteKit


extension ParkingWorkGame {
    
    // Initialize Chowerler
    func createChowerler(startEngine: Bool = false, hasBody: Bool = true) -> Car? {
        
        let chowerler = Car(
            scene: self,
            name: CAR_LIST.Chowerler.rawValue,
            initialSpeed: Chowerler.initialSpeed,
            maxSpeedForward: Chowerler.maxSpeedForward,
            maxSpeedBackward: Chowerler.maxSpeedBackward,
            turningSpeed: Chowerler.turningSpeed,
            accelerationRate: Chowerler.accelerationRate,
            secondaryAcceleration: Chowerler.secondaryAcceleration,
            brakeRate: Chowerler.brakeRate,
            smokeRate: Chowerler.smokeRate
        )

        guard let chowerlerNode = childNode(withName: CAR_TEXTURE_NAMES.chowerler) as? SKSpriteNode else {
            return nil
        }
        
        chowerler.node = chowerlerNode
        
        chowerlerNode.userData = NSMutableDictionary()
        chowerlerNode.userData?.setValue(chowerler.self, forKeyPath: "self")
        
        if hasBody {
            chowerlerNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.chowerler), size: chowerler.node!.size)
            
            chowerlerNode.physicsBody?.categoryBitMask = carCategory
            chowerlerNode.physicsBody?.collisionBitMask = boundaryCategory | carCategory | trashBakCategory
            chowerlerNode.physicsBody?.affectedByGravity = false
            chowerlerNode.physicsBody?.isDynamic = true
            chowerlerNode.physicsBody?.angularDamping = 3.4 // between 0.0 and 1.0
            chowerlerNode.physicsBody?.linearDamping = 12.0 // between 0.0 and 1.0
            chowerlerNode.physicsBody?.restitution = 0.01 // between 0.0 and 1.0
            chowerlerNode.physicsBody?.contactTestBitMask = boundaryCategory | carCategory | trashBakCategory
            
            chowerlerNode.physicsBody?.mass = 896
            
        }
        chowerlerNode.zPosition = 2
        chowerlerNode.anchorPoint = CGPoint(x: 0.49, y: 0.5)

        // old copper engine smoke
        let refNode = chowerlerNode.childNode(withName: "smoke-emitter")
        chowerler.smokeEmitter = refNode?.children[0] as? SKEmitterNode

        if startEngine {
            chowerler.startEngine()
        } else {
            chowerler.stopEngine()
        }

        // Chowerler sounds
        // Engine start sound
        let engineStartSound = EngineSound.old_copper_engine_start.audio
        engineStartSound.name = EngineSound.old_copper_engine_start.rawValue
        engineStartSound.autoplayLooped = false
        chowerler.node?.addChild(engineStartSound)

        // Engine accelerating sound
        let engineAcceleratingSound = EngineSound.old_copper_acceleration.audio
        engineAcceleratingSound.name = EngineSound.old_copper_acceleration.rawValue
        engineAcceleratingSound.autoplayLooped = false
        chowerler.node?.addChild(engineAcceleratingSound)

        // Engine driving sound
        let engineDrivingSound = EngineSound.old_copper_driving.audio
        engineDrivingSound.name = EngineSound.old_copper_driving.rawValue
        engineDrivingSound.autoplayLooped = false
        chowerler.node?.addChild(engineDrivingSound)

        // Engine still sound
        let engineStillSound = EngineSound.old_copper_engine_still.audio
        engineStillSound.name = EngineSound.old_copper_engine_still.rawValue
        engineStillSound.autoplayLooped = false
        engineStillSound.isPositional = true
        chowerler.node?.addChild(engineStillSound)

        // Signalization sound
        let signalizationSound = Sound.car_signalization.audio
        signalizationSound.name = Sound.car_signalization.rawValue
        signalizationSound.autoplayLooped = false
        chowerler.node?.addChild(signalizationSound)

        // Door locked sound
        let doorLockedSound = Sound.car_door_locked.audio
        doorLockedSound.name = Sound.car_door_locked.rawValue
        doorLockedSound.autoplayLooped = false
        chowerler.node?.addChild(doorLockedSound)
        return chowerler

    }
}
