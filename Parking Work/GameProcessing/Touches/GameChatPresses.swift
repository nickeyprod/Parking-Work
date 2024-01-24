//
//  GameChatPresses.swift
//  Parking Work
//
//  Created by Николай Ногин on 08.01.2024.
//

import Foundation
import SpriteKit

// Game Chat Touches Processing
extension ParkingWorkGame {
    func processGameChatPresses(touchedNode: SKNode) {
        
        switch touchedNode.buttonType {
            
        case .ScrollChatUp:
            scrollChatUp()
            
        case .ScrollChatDown:
            scrollChatDown()
            
        case .ScrollChatSlider:
            self.sliderTouchIsHolded = true
            
        default:
            return
        }
        
    }
}
