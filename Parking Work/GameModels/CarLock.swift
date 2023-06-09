//
//  CarLock.swift
//  Parking Work
//
//  Created by Николай Ногин on 02.06.2023.


import SpriteKit

struct CarLock {
    var type: String
    var node: SKNode
    var complexity: Float
    var unlocked: Bool
    var jammed: Bool
    
    var typeAsString: String {
        get {
            return LOCK_TRANSLATIONS[self.type] ?? "Неизвестный тип"
        }
    }

}
