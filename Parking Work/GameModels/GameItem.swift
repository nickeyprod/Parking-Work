//
//  GameItem.swift
//  Parking Work
//
//  Created by Николай Ногин on 25.05.2023.
//

import SpriteKit

struct GameItem: Equatable {
    static func == (lhs: GameItem, rhs: GameItem) -> Bool {
        lhs.type == rhs.type
    }
    
    var name: String
    var node: SKNode
    var type: String
    var assetName: String
    var description: String
//    var properties: GameItemProperties
}
