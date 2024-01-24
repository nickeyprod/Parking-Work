//
//  CarDriveButtonPresses.swift
//  Parking Work
//
//  Created by Николай Ногин on 08.01.2024.
//

import Foundation
import SpriteKit

extension ParkingWorkGame {
    
    func processCarDriveButtonPresses(touchedNode: SKNode) {
        switch touchedNode.buttonType {
        case .DriveButton:
            self.driveBtnHolded = true
            self.runButton?.run(.scale(to: 1.1, duration: 0))
        case .BrakeButton:
            self.brakeBtnHolded = true
            self.brakeButton?.run(.scale(to: 1.1, duration: 0))
        case .LeftArrowButton:
            self.leftArrowHolded = true
            self.leftButton?.run(.scale(to: 1.1, duration: 0))
        case .RightArrowButton:
            self.rightArrowHolded = true
            self.rightButton?.run(.scale(to: 1.1, duration: 0))
        case .LeaveCarButton:
            self.player?.getOutOfCar()
            self.exitFromCarBtn?.run(.scale(to: 1.1, duration: 0))
            run(MenuSounds.button_click.action)
        case .EnterCarButton:
            self.player?.getIn(the: player!.currTargetCar!)
            run(MenuSounds.button_click.action)
        default:
            return
        }
    }
}
