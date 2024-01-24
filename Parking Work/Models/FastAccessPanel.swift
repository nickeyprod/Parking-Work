//
//  FastAccessPanel.swift
//  Parking Work
//
//  Created by Николай Ногин on 23.01.2024.
//

import Foundation
import SpriteKit

/// This class controls behavior of FastAccessPanel. When user wants to make some action (e.g. open car lock), we show fast access panel with some number of slots, which user can touch to use item containing in this slot (picklock or something else).
class FastAccessPanel {
    
    var squareWidth: Int = 49
    var squareHeight: Int = 49
    var squareStroke: Int = 1
    var squareSize: CGSize {
        return CGSize(width: squareWidth + squareStroke, height: squareHeight + squareStroke)
    }
    
    // Space between two slots
    var marginBetweenSquares = 5
    
    // Center of the slot
    var slotCenterXPoint: Int {
        squareWidth / 2
    }
    
    var width: Int {
        return ((squareWidth + marginBetweenSquares) * numOfSlots)
    }
    
    // Slot structure, containing slot data
    struct Slot {
        var item: GameItem?
        var picture: SKSpriteNode?
        var slot: SKShapeNode?
        
        var isEmpty: Bool {
            return item == nil
        }
    }
    
    // number of slots in panel
    var numOfSlots: Int {
        return slots.count
    }
    
    // Default to 3 slots
    var slots: [Slot] = [
        Slot(),
        Slot(),
        Slot()
    ]
    
    // game class in which panel exists
    var scene: ParkingWorkGame?
    
    // main node of the panel, with slots in it
    var node: SKShapeNode?
    
    // Hide Fast Action panel from screen
    func hide() {
        node?.alpha = 0
        node?.run(.scale(to: 1.15, duration: 0.3), completion: { [weak self] in
            guard self != nil else { return }
            self!.node?.run(.scale(to: 0.0, duration: 0.15))
        })
    }
    
    // Show Fast Action panel on the screen
    func show(with items: [GameItem]) {
        // Fill panel with items before showing
        fillPanel(with: items)
        
        node?.alpha = 1
        node?.run(.scale(to: 1.15, duration: 0.3), completion: { [weak self] in
            guard self != nil else { return }
            self!.node?.run(.scale(to: 1.0, duration: 0.15))
        })
    }
    
    // Create shape of the panel
    func createPanel() {
        // Creating shape's path with rounded corners from rectangle of width and height
        let panelRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width + 4, height: 56))
        let shapePath = CGPath(roundedRect: panelRect, cornerWidth: 6.0, cornerHeight: 6.0, transform: .none)
        // Create Panel Shape Node from shape path
        let fastAccessPanel = SKShapeNode(path: shapePath, centered: true)
        
        // Set node to global Fast Panel class for hiding and showing ability
        self.node = fastAccessPanel
        
        // Color of the panel
        fastAccessPanel.fillColor = UIColor(named: COLORS.OpenCarWindowColor.rawValue)!
        fastAccessPanel.strokeColor = UIColor(named: COLORS.OpenCarWindowColorStroke.rawValue)!
        
        // Position of the panel
        fastAccessPanel.position = CGPoint(x: 20, y: -((self.scene!.displayHeight! / 2) - 28))
        
        self.scene?.cameraNode?.addChild(fastAccessPanel)
        
        // Initially hidden
        self.hide()
    }
    
    // Fill Slots with new items (update state)
    func fillPanel(with items: [GameItem]) {
        // clear node slots
        node?.removeAllChildren()
        
        // X Position of the first slot on a panel which will be increased
        var xPos = -(width / 2) + (slotCenterXPoint + marginBetweenSquares / 2)
       
        for i in 0...numOfSlots - 1 {
        
            // Create item square (slot) rectangle and path
            let slotRect = CGRect(origin: CGPoint(x: 0, y: 0), size: squareSize)
            let slotPath = CGPath(roundedRect: slotRect, cornerWidth: 6.0, cornerHeight: 6.0, transform: .none)
            
            // Create Item Slot Shape Node from shape path
            let itemSlot = SKShapeNode(path: slotPath, centered: true)
            itemSlot.fillColor = .black
            itemSlot.strokeColor = UIColor(named: COLORS.OpenCarWindowColorStroke.rawValue)!
            itemSlot.position = CGPoint(x: xPos, y: 0)
            self.slots[i].slot = itemSlot
            node?.addChild(itemSlot)
            
            // Adding Picture to slot if item exist, otherwise leave empty slot
            if i < (items.count) {
                let itemPic = SKSpriteNode(imageNamed: items[i].assetName)
                self.slots[i].picture = itemPic
                itemPic.userData = NSMutableDictionary()
                itemPic.userData?.setValue(i + 1, forKey: "slot-num")
                itemPic.userData?.setValue(GameButtons.FastAccessSlot, forKey: "btn-type")
                self.slots[i].item = items[i].self
                
                itemPic.zPosition = 15
                itemPic.size = CGSize(width: squareWidth, height: squareHeight)
                itemPic.position = CGPoint(x: 0, y: 0)
                itemSlot.addChild(itemPic)
            }
            xPos += squareWidth + marginBetweenSquares
        }
    }
    
    // Action when slot touched
    func touched(slotNum: Int) {
        
        // Get touched slot
        let touchedSlot = slots[slotNum - 1]

        // Check slot is not empty
        guard !touchedSlot.isEmpty else { return }
        
        if let itemPicture = touchedSlot.picture {
            // Throw (delete) Item from slot animation
            self.scene?.throwItem(item: itemPicture)
            
            // Run touch animation of touched slot picture
            itemPicture.run(.scale(to: 1.3, duration: 0.2)) {
                itemPicture.run(.scale(to: 1.0, duration: 0.1)) {
                    // Hide Panel after completed touch
                    self.hide()
                }
            }
        }
        
        // actually use item
        self.scene?.selectItemToUse(usedItem: touchedSlot.item!)

        
    }
}
