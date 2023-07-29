//
//  GameSounds.swift
//  Parking Work
//
//  Created by Николай Ногин on 17.02.2023.
//

import SpriteKit

enum Sound: String {
    case door_open, success_bell, car_door_locked, car_signalization, cigarette_falling, door_bell, breaking_glass
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: true)
    }
    
    var audio: SKAudioNode {
        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        audio.autoplayLooped = false

        return audio
    }
}

enum MissionListSounds: String {
    case mission_list_car_passing_by
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: true)
    }
    
    var audio: SKAudioNode? {
        guard let urlString = Bundle.main.path(forResource: rawValue, ofType: "wav") else { return nil }
        let audio = SKAudioNode(url: URL(fileURLWithPath: urlString))
        
        return audio
    }
}

enum MenuSounds: String {
    case button_click, upper_popup_sound
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: false)
    }
    
    var audio: SKAudioNode? {
//        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        guard let urlString = Bundle.main.path(forResource: rawValue, ofType: "wav") else { return nil }

        let audio = SKAudioNode(url: URL(fileURLWithPath: urlString))
        
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
    case old_copper_engine_start, old_copper_acceleration, old_copper_driving, old_copper_engine_still
    case posblanc_driving_by_streets, chowerler_driving_by_streets
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: false)
    }
    
    var audio: SKAudioNode {
        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        return audio
    }
}

enum CarCollisionSounds: String {
    case car_collision_01, car_collision_02, car_collision_03, plastic_hit, brake_bump

    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: true)
    }
    
    var audio: SKAudioNode? {
        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        audio.isPositional = true
        return audio
    }
}

enum InventorySounds: String {
    case bag_open, pickup_inventory
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: true)
    }
}

enum ExplosionSounds: String {
    case car_on_fire, explosion
    
    var action: SKAction {
        return SKAction.playSoundFileNamed(rawValue + ".wav", waitForCompletion: true)
    }
    
    var audio: SKAudioNode? {
        let audio = SKAudioNode(fileNamed: "\(rawValue).wav")
        audio.isPositional = true
        return audio
    }
}

