//
//  Player.swift
//  Parking Work
//
//  Created by Николай Ногин on 23.03.2023.
//

import SpriteKit

class Player {
    
    init(scene: SKScene, name: String, node: SKNode? = nil) {
        self.scene = (scene as? ParkingWorkGame)!
        self.name = name
        self.node = node
    }
    
    let scene: ParkingWorkGame
    
    // Player name
    let name: String
    
    var destinationPosition: CGPoint?
    
    // Last Opened mission
    var processedMissions: [Int: String] = [
        1: "opened",
    ]
    
    var unlockSkill: Float = 10.0
    var reputation: Float = 0.0
    var money: Float = 75.0
    
    var inventoryMaxCapacity: Int = 20
    var inventory: [GameItem?] = []

    // node
    var node: SKNode?
    
    var miniMapDot: SKShapeNode?
    
    // Target
    var currTargetCar: Car?
    var currTargetItem: GameItem?
    var currTargetLock: CarLock?
    
    var triedToOpenComplexLockTimes = 0
    var triedToOpenJammedLockTimes = 0
    
    var isSittingInCar: Bool = false
    var drivingCar: Car?
    

}
