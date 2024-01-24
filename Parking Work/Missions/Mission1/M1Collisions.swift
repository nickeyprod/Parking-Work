//
//  M1Collisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.12.2023.
//

import Foundation
import SpriteKit

// Mission 1 Collision Processing
extension ParkingWorkGame {
    func M1CollisionProcess(contactMask: UInt32) {
        
        switch contactMask {
        // Mission 1 Completion Trigger Actions 
        case (carCategory | completionSquareCategory):
            if canShowCompletionMissionMessage {
                canShowCompletionMissionMessage = false
                runMissionCompletedScreen(money: MISSIONS.Mission1.Awards.money, reputation: MISSIONS.Mission1.Awards.reputation)
            }
        // When user trying to leave level without a car
        case (playerCategory | completionSquareCategory):
            if canShowCompletionMissionMessage {
                canShowCompletionMissionMessage = false
                pushMessageToChat(text: "Вы не должны уходить с парковки без машины!")
            }
           
        default:
            return
        }
    }
    
}
