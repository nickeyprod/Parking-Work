//
//  ShopItem.swift
//  Parking Work
//
//  Created by Николай Ногин on 14.06.2023.
//

import SpriteKit

struct ShopItem: Equatable {
    static func == (lhs: ShopItem, rhs: ShopItem) -> Bool {
        lhs.type == rhs.type
    }
    
    var name: String
    var onlyForRealMoney: Bool
    var node: SKNode
    var type: String
    var price: Price
    var assetName: String
    var description: String
    var properties: [Property]
}
