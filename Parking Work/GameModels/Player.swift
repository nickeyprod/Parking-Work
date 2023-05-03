//
//  Player.swift
//  Parking Work
//
//  Created by Николай Ногин on 23.03.2023.
//

import SpriteKit

class Player {
    
    init(scene: SKScene, name: String, node: SKNode) {
        self.scene = (scene as? ParkingWorkGame)!
        self.name = name
        self.node = node
    }
    
    let scene: ParkingWorkGame
    
    // Player name
    let name: String
    
    var destinationPosition: CGPoint?
    
    var unlockSkill: Float = 10.0

    // node
    var node: SKNode?
    
    var miniMapDot: SKShapeNode?
    
    // Target
    var currTargetCar: Car?
    var currLockTarget: SKNode?
    var triedToOpenComplexLockTimes = 0
    var triedToOpenJammedLockTimes = 0
    
    var ownedCars: [Car?] = []
    
    var isSittingInCar: Bool = false
    var drivingCar: Car? 
    
}
