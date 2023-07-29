//
//  SetupCars.swift
//  Parking Work
//
//  Created by Николай Ногин on 10.07.2023.
//

import SpriteKit

// Mission 2 Cars Setup
extension Mission2 {
    func setupCars() {

        // Old Copper
        if let oldCopper = createOldCopper(startEngine: false) {
            carsOnLevel.append(oldCopper)
            OldCopperCar = oldCopper
        }
    
        
        // Chowerler
        // Chowerler
        if let chowerler = createChowerler(startEngine: true, hasBody: true) {
            chowerler.node?.physicsBody?.collisionBitMask = playerCategory
            chowerler.node?.physicsBody?.contactTestBitMask = playerCategory
            
            // chowerler sounds
            let chowerlerEngineDrivingSound = EngineSound.chowerler_driving_by_streets.audio
            chowerlerEngineDrivingSound.name = "driving-sound"
            chowerlerEngineDrivingSound.isPositional = true
            chowerlerEngineDrivingSound.autoplayLooped = true
            chowerler.node?.addChild(chowerlerEngineDrivingSound)
            
            carsOnLevel.append(chowerler)
            ChowerlerCar = chowerler
        }

        // Posblanc
        if let posblanc = createPosblanc(startEngine: true, hasBody: true) {
            posblanc.node?.physicsBody?.collisionBitMask = playerCategory
            posblanc.node?.physicsBody?.contactTestBitMask = playerCategory
            
            let posblancEngineDrivingSound = EngineSound.posblanc_driving_by_streets.audio
            posblancEngineDrivingSound.name = "driving-sound"
            posblancEngineDrivingSound.isPositional = true
            posblancEngineDrivingSound.autoplayLooped = true
            posblanc.node?.addChild(posblancEngineDrivingSound)
            posblancEngineDrivingSound.run(.changeVolume(to: 0.4, duration: 0))
            
            carsOnLevel.append(posblanc)
            PosblancCar = posblanc
        }
    }
    
    func runSmokeFromOldCopperWindow() {
        self.raiseAnxiety(to: 8)
        OldCopperWindowSmokeEmitter?.particleBirthRate = 40
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
            self.OldCopperWindowSmokeEmitter?.particleBirthRate = 30
        }
        
        Timer.scheduledTimer(withTimeInterval: 16, repeats: false) { _ in
            self.OldCopperWindowSmokeEmitter?.particleBirthRate = 20
        }
        
        Timer.scheduledTimer(withTimeInterval: 22, repeats: false) { _ in
            self.OldCopperWindowSmokeEmitter?.particleBirthRate = 5
        }
    }
    
    func runFireFromOldCopperWindow() {
        OldCopperWindowFireEmitter?.particleBirthRate = 340
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
            self.OldCopperWindowFireEmitter?.particleBirthRate = 230
        }
        
        Timer.scheduledTimer(withTimeInterval: 16, repeats: false) { _ in
            self.OldCopperWindowFireEmitter?.particleBirthRate = 60
        }
        
        Timer.scheduledTimer(withTimeInterval: 22, repeats: false) { _ in
            self.OldCopperWindowFireEmitter?.particleBirthRate = 0
        }
    }
    
    func runMainSmokeFromOldCopper() {
        OldCopperMainSmokeEmitter?.particleBirthRate = 60
        
        Timer.scheduledTimer(withTimeInterval: 21, repeats: false) { _ in
            self.OldCopperMainSmokeEmitter?.particleBirthRate = 30
        }
        
        Timer.scheduledTimer(withTimeInterval: 36, repeats: false) { _ in
            self.OldCopperMainSmokeEmitter?.particleBirthRate = 10
        }
    }
    
    func runMainFireFromOldCopper() {
        OldCopperMainFireEmitter?.particleBirthRate = 485
        
        Timer.scheduledTimer(withTimeInterval: 6, repeats: false) { _ in
            self.OldCopperMainFireEmitter?.particleBirthRate = 674
        }
        
        Timer.scheduledTimer(withTimeInterval: 14, repeats: false) { _ in
            self.OldCopperMainFireEmitter?.particleBirthRate = 844
        }
        
        Timer.scheduledTimer(withTimeInterval: 21, repeats: false) { _ in
            self.OldCopperMainFireEmitter?.particleBirthRate = 400
        }
        
        Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { _ in
            self.OldCopperMainFireEmitter?.particleBirthRate = 200
        }
        Timer.scheduledTimer(withTimeInterval: 36, repeats: false) { _ in
            self.OldCopperMainFireEmitter?.particleBirthRate = 20
            if let oldCopperNode = self.childNode(withName: CAR_TEXTURE_NAMES.oldCopper) {
                if let fireAudio = oldCopperNode.childNode(withName: ExplosionSounds.car_on_fire.rawValue) {
                    fireAudio.run(.stop())
                    fireAudio.removeFromParent()
                }
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 42, repeats: false) { _ in
            self.OldCopperMainFireEmitter?.particleBirthRate = 0
        }
        
    }
    
    func blowOldCopper() {
    
        let textures: Array <SKTexture> = [
            SKTexture(imageNamed: "OldCopper_blown_01"),
            SKTexture(imageNamed: "OldCopper_blown_02"),
            SKTexture(imageNamed: "OldCopper_blown_03"),
            SKTexture(imageNamed: "OldCopper_blown_04")
        ]
  
        let blownAction = SKAction.animate(with: textures, timePerFrame: 6.35)
  
        if let node = OldCopperCar?.node {
            
            runSmokeFromOldCopperWindow()
            
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                self.runFireFromOldCopperWindow()
                
                let carOnFireAudio = ExplosionSounds.car_on_fire.audio
                carOnFireAudio?.name = ExplosionSounds.car_on_fire.rawValue
                carOnFireAudio?.autoplayLooped = true
                node.addChild(carOnFireAudio!)
                
            }
            
            Timer.scheduledTimer(withTimeInterval: 6, repeats: false) { _ in
                self.runMainSmokeFromOldCopper()
            }
            
            Timer.scheduledTimer(withTimeInterval: 8.2, repeats: false) { _ in
                
                self.raiseAnxiety(to: 20)
                
                let explosionAudio = ExplosionSounds.explosion.audio
                explosionAudio?.name = ExplosionSounds.explosion.rawValue
                explosionAudio?.autoplayLooped = false
                node.addChild(explosionAudio!)
                explosionAudio?.run(.play())
                self.runMainFireFromOldCopper()
                
                node.run(blownAction)
            }
            
        
            
            
        }
        

    }

}
