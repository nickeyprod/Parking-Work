//
//  GameButtons.swift
//  Parking Work
//
//  Created by Николай Ногин on 29.12.2023.
//

import Foundation

enum GameButtons {
    
    // Game Playing
    case TaskButton
    case MenuButton
    case RunButton
    case ActionYesButton
    case GoodButton
    
    // Inventory
    case InventoryButton
    case CloseInventoryButton
    
    // Game Chat
    case ScrollChatUp
    case ScrollChatDown
    case ScrollChatSlider
    
    // Car Drive
    case EnterCarButton
    case DriveButton
    case BrakeButton
    case LeaveCarButton
    
    // Arrows
    case LeftArrowButton
    case RightArrowButton
    
    // Game Menu
    case CloseTaskScreenButton
    case ResumeGameButton
    case OpenGameSettingsButton
    
    // Game Item
    case GameItem
    case FastAccessSlot
    
    // Specific Case (SKNode Not A Button)
    case notAButton
}

enum ItemLocation {
    case UserInventory
    case UserPanel
    case Unknown
}
