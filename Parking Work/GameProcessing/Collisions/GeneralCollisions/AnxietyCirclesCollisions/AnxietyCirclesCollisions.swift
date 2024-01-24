//
//  AnxietyCirclesCollisions.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.12.2023.
//

import Foundation

extension ParkingWorkGame {
    func anxietyCirclesCollisionProcess(for contactMask: UInt32) {
        switch contactMask {
        case (playerCategory | firstCircleCategory):
            playerInFirstCircle = false
            reduceAnxiety(to: 1)
        case (playerCategory | secondCircleCategory):
            playerInSecondCircle = false
            reduceAnxiety(to: 0.5)
        case (playerCategory | thirdCircleCategory):
            playerInThirdCircle = false
            reduceAnxiety(to: 0.3)
        default:
            return
        }
    }
    
    func anxietyCirclesCollisionEndedProcess(for contactMask: UInt32) {
        switch contactMask {
        case (playerCategory | completionSquareCategory):
            canShowCompletionMissionMessage = true
        default:
            return
        }
    }
}
