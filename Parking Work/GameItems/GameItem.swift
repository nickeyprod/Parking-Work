//
//  GameItem.swift
//  Parking Work
//
//  Created by Николай Ногин on 25.05.2023.
//

import SpriteKit

protocol GameItem {
    var name: String { get set }
    var picture: SKSpriteNode? { get set }
}
