//
//  ActionButtonsPresses.swift
//  Parking Work
//
//  Created by Николай Ногин on 08.01.2024.
//

import Foundation
import SpriteKit

extension ParkingWorkGame {
    func processActionButtonPresses(touchedNode: SKNode) {
        
        switch touchedNode.buttonType {
        case .ActionYesButton:
            // off opening car when tutorial message is opened
            if !canMoveCamera { return }
            
            touchedNode.buttonShape.run(.scale(to: 1.1, duration: 0.2), completion: {
                touchedNode.buttonShape.run(.scale(to: 1.0, duration: 0.1))
                if self.actionMessageType == .OpenCarAction {
                    
                    self.hideActionMessage()
                    
                    // create here Fast Access Panel for choosing pick lock(item) that user will be using
                    let foundPicklocks = self.getItemsFromInventory(with: ITEMS_TYPES.PICKLOCKS.TYPE)
                    
                    if foundPicklocks.count == 0 {
                        // show message that no picklocks
                        self.pushMessageToChat(text: "У вас нет отмычек!")
                        // add tries if player trying to open again and again
                        self.player?.tryingOpenLock(car: self.player!.currTargetCar!, type: "no-picklocks")
                        return
                    }
                    
//                    let numOfSquares = foundPicklocks.count < 3 ? 3 : foundPicklocks.count
            
                    // Show Fast Access Panel with found picklocks
                    self.fastAccessPanel?.show(with: foundPicklocks)

                } else if self.actionMessageType == .PickUpItemAction {
                    self.player!.pickUpTargetItem()
                }
            })
            
            run(MenuSounds.button_click.action)
            
        case .GoodButton:
            // hide open success message and play button click sound
            hideCarOpenedSuccessMessage()
            run(MenuSounds.button_click.action)
            
        default:
            return
        }
    }
}
