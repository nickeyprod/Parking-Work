//
//  GameSounds.swift
//  Parking Work
//
//  Created by Николай Ногин on 17.02.2023.
//

import SpriteKit

enum Sound: String {
    case door_open, success_bell, car_door_locked, car_signalization
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: false)
    }
}

enum CitySound: String {
    case traffic1
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: true)
    }
}

enum EngineSound: String {
    case posblanc_drive
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: false)
    }
}
