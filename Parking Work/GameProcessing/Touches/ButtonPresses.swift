//
//  ButtonPresses.swift
//  Parking Work
//
//  Created by Николай Ногин on 08.01.2024.
//

import Foundation
import SpriteKit


// User Interface Button Presses Processing
extension ParkingWorkGame {
    func processUIButtonPresses(touchedNode: SKNode) {
        
        switch touchedNode.buttonType {
            
        case .TaskButton:
            showTaskScreen()
            run(MenuSounds.button_click.action)
            
        case .MenuButton:
            showMenuScreen()
            run(MenuSounds.button_click.action)
            
        case .RunButton:
            isRunButtonHolded = true
            self.runButton?.run(.scale(to: 1.2, duration: 0))
            
        case .CloseTaskScreenButton:
            hideTaskScreen()
            run(MenuSounds.button_click.action)
            
        case .ResumeGameButton:
            hideMenuScreen()
            run(MenuSounds.button_click.action)
            
        case .OpenGameSettingsButton:
            showSettingsScreen()
            run(MenuSounds.button_click.action)
            
            
        default:
            return
        }
        
    }
}
