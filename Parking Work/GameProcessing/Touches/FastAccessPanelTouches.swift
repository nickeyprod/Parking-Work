//
//  FastAccessPanelTouches.swift
//  Parking Work
//
//  Created by Николай Ногин on 23.01.2024.
//

import Foundation
import SpriteKit

extension ParkingWorkGame {
    func processFastAccessPanelTouches(touchedNode: SKNode) {
        
        switch touchedNode.buttonType {
        case .FastAccessSlot:
            // action on touch of slot num
            if let slotNum = touchedNode.userData?.value(forKey: "slot-num") as? Int {
                self.fastAccessPanel?.touched(slotNum: slotNum)
            }
            
        default:
            return
        }
    }
}
