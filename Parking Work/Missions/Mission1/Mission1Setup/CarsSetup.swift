//
//  CarsSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Mission 1 Cars Setup
extension Mission1 {
    func setupCars() {
        
        let oldCopper = Car(scene: self, name: CAR_LIST.OldCopper.rawValue, initialSpeed: 4, maxSpeedForward: 150, maxSpeedBackward: 60, turningSpeed: 0.006, accelerationRate: 1, secondaryAcceleration: 0.01, brakeRate: 1.5, smokeRate: 10)
        let chowerler = Car(scene: self, name: CAR_LIST.Chowerler.rawValue, initialSpeed: 10, maxSpeedForward: 200, maxSpeedBackward: 75, turningSpeed: 0.012, accelerationRate: 1, secondaryAcceleration: 0.01, brakeRate: 2, smokeRate: 10)
        
        // Old Copper
        oldCopper.node = childNode(withName: CAR_TEXTURE_NAMES.oldCopper) as? SKSpriteNode
        oldCopper.node?.userData = NSMutableDictionary()
        oldCopper.node?.userData?.setValue(oldCopper.self, forKeyPath: "self")
        oldCopper.node?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.oldCopper), size: oldCopper.node!.size)
        
        oldCopper.node?.physicsBody?.categoryBitMask = carCategory
        oldCopper.node?.physicsBody?.collisionBitMask = boundaryCategory | carCategory | trashBakCategory
        oldCopper.node?.physicsBody?.affectedByGravity = false
        oldCopper.node?.physicsBody?.isDynamic = true
        oldCopper.node?.physicsBody?.angularDamping = 3.4 // between 0.0 and 1.0
        oldCopper.node?.physicsBody?.linearDamping = 12.0 // between 0.0 and 1.0
        oldCopper.node?.physicsBody?.restitution = 0.01 // between 0.0 and 1.0
        oldCopper.node?.physicsBody?.contactTestBitMask = boundaryCategory | carCategory | trashBakCategory
        
        oldCopper.node?.physicsBody?.mass = 896
        oldCopper.node?.zPosition = 2
        oldCopper.node?.anchorPoint = CGPoint(x: 0.49, y: 0.5)
        
        
        // old copper engine smoke
        var refNode = oldCopper.node!.childNode(withName: "smoke-emitter")
        oldCopper.smokeEmitter = refNode?.children[0] as? SKEmitterNode
        oldCopper.stopEngine()
        
        // old copper sounds
        // old copper engine start sound
        let oldCopperEngineStartSound = EngineSound.old_copper_engine_start.audio
        oldCopperEngineStartSound.name = EngineSound.old_copper_engine_start.rawValue
        oldCopperEngineStartSound.autoplayLooped = false
        oldCopper.node?.addChild(oldCopperEngineStartSound)
        
        // old copper engine accelerating sound
        let oldCopperEngineAcceleratingSound = EngineSound.old_copper_acceleration.audio
        oldCopperEngineAcceleratingSound.name = EngineSound.old_copper_acceleration.rawValue
        oldCopperEngineAcceleratingSound.autoplayLooped = false
        oldCopper.node?.addChild(oldCopperEngineAcceleratingSound)
        
        // old copper engine driving sound
        let oldCopperEngineDrivingSound = EngineSound.old_copper_driving.audio
        oldCopperEngineDrivingSound.name = EngineSound.old_copper_driving.rawValue
        oldCopperEngineDrivingSound.autoplayLooped = false
        oldCopper.node?.addChild(oldCopperEngineDrivingSound)
        
        // old copper engine still sound
        let oldCopperEngineStillSound = EngineSound.old_copper_engine_still.audio
        oldCopperEngineStillSound.name = EngineSound.old_copper_engine_still.rawValue
        oldCopperEngineStillSound.autoplayLooped = false
        oldCopperEngineStillSound.isPositional = true
        oldCopper.node?.addChild(oldCopperEngineStillSound)
        
        // old copper signalization sound
        let oldCopperSignalizationSound = Sound.car_signalization.audio
        oldCopperSignalizationSound.name = Sound.car_signalization.rawValue
        oldCopperSignalizationSound.autoplayLooped = false
        oldCopper.node?.addChild(oldCopperSignalizationSound)
        
        // old copper door locked sound
        let oldCopperDoorLockedSound = Sound.car_door_locked.audio
        oldCopperDoorLockedSound.name = Sound.car_door_locked.rawValue
        oldCopperDoorLockedSound.autoplayLooped = false
        oldCopper.node?.addChild(oldCopperDoorLockedSound)
        
        
        carsOnLevel.append(oldCopper)
    
        // Chowerler
        chowerler.node = childNode(withName: CAR_TEXTURE_NAMES.chowerler) as? SKSpriteNode
        chowerler.node?.userData = NSMutableDictionary()
        chowerler.node?.userData?.setValue(chowerler.self, forKeyPath: "self")
        chowerler.node?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.chowerler), size: chowerler.node!.size)
        chowerler.node?.physicsBody?.categoryBitMask = carCategory
        chowerler.node?.physicsBody?.collisionBitMask = boundaryCategory | carCategory | trashBakCategory
        chowerler.node?.physicsBody?.contactTestBitMask = boundaryCategory | carCategory | trashBakCategory
        chowerler.node?.physicsBody?.affectedByGravity = false
        chowerler.node?.physicsBody?.isDynamic = true
        
        chowerler.node?.anchorPoint = CGPoint(x: 0.49, y: 0.495)
        chowerler.node?.physicsBody?.angularDamping = 3.4
        chowerler.node?.physicsBody?.linearDamping = 12.0
        chowerler.node?.physicsBody?.restitution = 0.01
        
        // chowerler engine smoke
        refNode = chowerler.node!.childNode(withName: "smoke-emitter")
        chowerler.smokeEmitter = refNode?.children[0] as? SKEmitterNode
        chowerler.stopEngine()
        
        
        chowerler.node?.physicsBody?.mass = 1061
        chowerler.node?.zPosition = 2
        
        // chowerler sounds
        // ..
        
        carsOnLevel.append(chowerler)
    }

}
