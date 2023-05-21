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
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: true)
    }
    
    var audio: SKAudioNode {
        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        audio.autoplayLooped = false

        return audio
    }
}

enum MenuSounds: String {
    case button_click
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: false)
    }
    
    var audio: SKAudioNode {
        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        return audio
    }
}

enum CitySound: String {
    case traffic1, street_sound_birds, pigeon_flying_away
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: true)
    }
    
    var audio: SKAudioNode {
        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        audio.autoplayLooped = false
        return audio
    }
}

enum EngineSound: String {
    case old_copper_engine_start
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: false)
    }
    
    var audio: SKAudioNode {
        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        audio.isPositional = true
        return audio
    }
}

enum CarCollisionSounds: String {
    case car_collision_01, car_collision_02, car_collision_03

    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: false)
    }
    
    var audio: SKAudioNode {
        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        audio.isPositional = true
        return audio
    }
}
