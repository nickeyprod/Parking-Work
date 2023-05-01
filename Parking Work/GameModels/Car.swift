//
//  Car.swift
//  Parking Work
//
//  Created by Николай Ногин on 02.03.2023.
//

import SpriteKit


class Car: Equatable {
    static func == (lhs: Car, rhs: Car) -> Bool {
        lhs.node == rhs.node
    }
    
    
    init(scene: SKScene, name: String) {
        self.scene = (scene as? ParkingWorkGame)!
        self.name = name
    }
    
    let scene: ParkingWorkGame
    
    // car name
    let name: String
    
    // locks list
    var locks: [String: Float?] = [
        "driver_lock": nil,
        "passenger_lock": nil,
    ]
    
    var jammedLocks: [String?] = []
    
    // other variables
    var signaling: Bool = false
    var stolen: Bool = false

    // node
    var node: SKNode? = nil {
        didSet {
            let radius = node!.frame.width - node!.frame.width / 3
            let circle = SKShapeNode(circleOfRadius: radius)
            circle.strokeColor = .red
            circle.position = CGPoint(x: 0, y: 0)
            node?.addChild(circle)
            
            circle.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            circle.physicsBody?.categoryBitMask = scene.firstCircleCategory
            circle.physicsBody?.contactTestBitMask = scene.playerCategory
            circle.physicsBody?.affectedByGravity = false
            circle.physicsBody?.isDynamic = false
            circle.alpha = 0
            firstAnxietyCircle = circle
            
            let radius2 = node!.frame.width - node!.frame.width / 25
            let circle2 = SKShapeNode(circleOfRadius: radius2)
            circle2.strokeColor = .blue
            circle2.position = CGPoint(x: 0, y: 0)
            node?.addChild(circle2)
            
            circle2.physicsBody = SKPhysicsBody(circleOfRadius: radius2)
            circle2.physicsBody?.categoryBitMask = scene.secondCircleCategory
            circle2.physicsBody?.contactTestBitMask = scene.playerCategory
            circle2.physicsBody?.affectedByGravity = false
            circle2.physicsBody?.isDynamic = false
            circle2.alpha = 0
            secondAnxietyCircle = circle2
            
            let radius3 = node!.frame.width + node!.frame.width / 3
            let circle3 = SKShapeNode(circleOfRadius: radius3)
            circle3.strokeColor = .white
            circle3.position = CGPoint(x: 0, y: 0)
            node?.addChild(circle3)
            
            circle3.physicsBody = SKPhysicsBody(circleOfRadius: radius3)
            circle3.physicsBody?.categoryBitMask = scene.thirdCircleCategory
            circle3.physicsBody?.contactTestBitMask = scene.playerCategory
            circle3.physicsBody?.affectedByGravity = false
            circle3.physicsBody?.isDynamic = false
            circle3.alpha = 0
            thirdAnxietyCircle = circle3
            
        }
    }
    
    var miniMapDot: SKShapeNode?
    
    // anxiety circles
    var firstAnxietyCircle: SKShapeNode?
    
    var secondAnxietyCircle: SKShapeNode?
    var thirdAnxietyCircle: SKShapeNode?
}
