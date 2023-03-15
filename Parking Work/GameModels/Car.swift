//
//  Car.swift
//  Parking Work
//
//  Created by Николай Ногин on 02.03.2023.
//

import SpriteKit

class Car {
    
    init(name: String) {
        self.name = name
    }
    
    // car name
    let name: String
    
    // locks list
    var locks: [String: Float?] = [
        "driver_lock": nil,
        "passenger_lock": nil,
    ]
    
    // other variables
    var signaling: Bool = false
    var stolen: Bool = false
    

    // node
    var node: SKNode?
    var miniMapDot: SKShapeNode?
}
