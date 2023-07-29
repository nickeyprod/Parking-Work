//
//  M2ActionsSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 26.07.2023.
//

import Foundation

extension Mission2 {
    func performAction(name: String) {
        if name == "door-action" && !doorRinged {
            doorRinged = true
            print("Ring the door")
        }
    }
}
