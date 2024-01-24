//
//  M2SetupEmitters.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.07.2023.
//

import Foundation

import SpriteKit

// Mission 2 Emitters Setup
extension Mission2 {
    func setupEmitters() {
        
        if (OldCopperCar?.node) != nil {
            OldCopperWindowSmokeEmitter?.particleBirthRate = 0
            OldCopperWindowFireEmitter?.particleBirthRate = 0
            OldCopperMainFireEmitter?.particleBirthRate = 0
            OldCopperMainSmokeEmitter?.particleBirthRate = 0
            
            // off cigarette emitter
            cigaretteItemEmitter?.particleBirthRate = 0 // initial 15
        }
    }
}
