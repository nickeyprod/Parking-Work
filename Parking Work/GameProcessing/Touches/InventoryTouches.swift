//
//  InventoryTouches.swift
//  Parking Work
//
//  Created by Николай Ногин on 09.01.2024.
//

import Foundation
import SpriteKit

extension ParkingWorkGame {
    func processInventoryTouches(touchedNode: SKNode) {

        switch touchedNode.buttonType {
        case .InventoryButton:
            self.inventoryButton?.run(.scale(to: 1.2, duration: 0.2), completion: {
                self.inventoryButton?.run(.scale(to: 1.0, duration: 0.1))
            })
            
            
            !isInventoryOpened ? openInventory() : closeInventory()
            run(InventorySounds.bag_open.action)
        case .CloseInventoryButton:
            run(InventorySounds.bag_open.action)
            
            touchedNode.buttonShape.run(.scale(to: 1.2, duration: 0.2), completion: {
                touchedNode.buttonShape.run(.scale(to: 1.0, duration: 0.1))
                if self.isInventoryOpened {
                    self.closeInventory()
                }
            })
        case .GameItem:
           if touchedNode.itemLocation == .UserInventory {
                if let item = touchedNode.userData?.value(forKeyPath: "self") as? GameItem {
                    showDescriptionOf(item: item, touchedNode: touchedNode)
                } else if touchedNode.name == "inventory-item-selection" {
                    hideDescriptionOfItem()
                }
            }
        default:
            return
        }
    }
}
