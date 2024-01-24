//
//  GameScreenControls.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

// Game Screen Control Functions
extension ParkingWorkGame {
    
    // Shows Task Screen
    func showTaskScreen() {
        taskScreen?.run(SKAction.fadeAlpha(to: 0.9, duration: 0.2), completion: {
            self.isPaused = true
        })
        miniMapCropNode?.zPosition = 45

    }
    
    // Hides Task Screen
    func hideTaskScreen() {
        taskScreen?.alpha = 0
        self.isPaused = false
        self.miniMapCropNode?.zPosition = 2
    }
    
    // Shows Main Menu Screen
    func showMenuScreen() {
        menuScreen?.run(SKAction.fadeAlpha(to: 1.0, duration: 0.2), completion: {
            self.isPaused = true
        })
    }
    
    // Hides Main Menu Screen
    func hideMenuScreen() {
        menuScreen?.alpha = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            self.isPaused = false
        }
    }
    
    // Show Settings Screen
    func showSettingsScreen() {
        print("show settings!")
//        settingsScreen?.run(SKAction.fadeAlpha(to: 0.9, duration: 0.2), completion: {
//            self.isPaused = true
//        })
    }
    
    // Hides Settings Screen
    func hideSettingsScreen() {
        settingsScreen?.alpha = 0
    }
    
}
