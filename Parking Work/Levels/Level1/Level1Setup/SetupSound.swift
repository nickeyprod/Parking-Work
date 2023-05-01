//
//  SetupSound.swift
//  Parking Work
//
//  Created by Николай Ногин on 20.04.2023.
//


import SpriteKit

// Level 1 Cars Setup
extension Level1 {
  
    
    func setupSounds() {
        // play city street background sound
        let citySoundBirds = CitySound.street_sound_birds.audio
        citySoundBirds.autoplayLooped = true
        self.addChild(citySoundBirds)
        
        citySoundBirds.run(SKAction.play())
    }

}

