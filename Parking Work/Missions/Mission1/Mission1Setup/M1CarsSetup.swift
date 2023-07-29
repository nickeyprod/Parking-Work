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
        
        // Old Copper
        if let oldCopper = createOldCopper() {
            carsOnLevel.append(oldCopper)
        }
        
        // Chowerler
        if let chowerler = createChowerler() {
            carsOnLevel.append(chowerler)
        }
        
        // Posblanc
        if let posblanc = createPosblanc(startEngine: true, hasBody: false) {
            carsOnLevel.append(posblanc)
        }
        
        // Policia
        if let policia = createPolicia(startEngine: true, hasBody: false) {
            
            let chowerlerEngineDrivingSound = EngineSound.chowerler_driving_by_streets.audio
            chowerlerEngineDrivingSound.name = "driving-sound"
            chowerlerEngineDrivingSound.isPositional = true
            chowerlerEngineDrivingSound.autoplayLooped = true
            policia.node?.addChild(chowerlerEngineDrivingSound)
            
            carsOnLevel.append(policia)
        }
    }

}
