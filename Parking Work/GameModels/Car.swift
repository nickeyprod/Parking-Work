//
//  Car.swift
//  Parking Work
//
//  Created by Николай Ногин on 02.03.2023.
//

import SpriteKit
import Foundation


class Car: Equatable {
    
    enum TurningDirections {
        case left
        case right
    }

    static func == (lhs: Car, rhs: Car) -> Bool {
        lhs.node == rhs.node
    }
    
    init(scene: SKScene, name: String, maxSpeed: CGFloat, turningSpeed: CGFloat) {
        self.scene = (scene as? ParkingWorkGame)!
        self.name = name
        self.maxSpeed = maxSpeed
        self.turningSpeed = turningSpeed
    }
    
    let scene: ParkingWorkGame
    
    // car name
    let name: String
    
    // car sound
    var engineStarts: SKAction?
    
    // locks list
    var locks: [String: Float?] = [
        "driver_lock": nil,
        "passenger_lock": nil,
        ]
    
    var jammedLocks: [String?] = []
    
    // other variables
    var signaling: Bool = false
    var stolen: Bool = false
    var isDriving: Bool = false
    var prevMoveIsForward: Bool = false
    var currDrivingPoint: CGPoint?
    var movingVector: CGVector?
    
    var maxSpeed: CGFloat?
    var turningSpeed: CGFloat?

    var unlockedLocks : [String: Bool] = [
        "driver_lock": false,
        "passenger_lock": false
    ]

    // node
    var node: SKSpriteNode? = nil {
        didSet {
            // add three anxiety circles
            self.addAnxietyCircles()
        }
    }
    
    var miniMapDot: SKShapeNode?
    
    // anxiety circles
    var firstAnxietyCircle: CGFloat?
    var secondAnxietyCircle: CGFloat?
    var thirdAnxietyCircle: CGFloat?
    
    func addAnxietyCircles() {
        let radius1 = (node!.frame.width / 2) - node!.frame.width / 3
        firstAnxietyCircle = radius1
        
        let radius2 = (node!.frame.width / 2) - node!.frame.width / 25
        secondAnxietyCircle = radius2

        let radius3 = (node!.frame.width / 2) + node!.frame.width / 3
        thirdAnxietyCircle = radius3
    }
    
    func createAnxietyCircle(of radius: CGFloat, color: UIColor) {
        let circle = SKShapeNode(circleOfRadius: radius)
        circle.alpha = 1
        circle.strokeColor = color
        
        self.node?.addChild(circle)
    }
    
    func blinkLightSignals() {
        
        let lightSignals = self.node?.childNode(withName: "light_signals")
        
        let signalingTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(blinkLights), userInfo: lightSignals, repeats: true)
        
        // stop signal after 15 seconds
        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
            signalingTimer.invalidate()
            self.signaling = false
        }
       
    }
    
    @objc func blinkLights(sender: Timer) {
        let lightSignals = sender.userInfo as? SKNode
        if lightSignals?.alpha == 0  {
            lightSignals?.alpha = 1
        } else {
            lightSignals?.alpha = 0
        }
        
    }

    func turn(to direction: TurningDirections) {
        var angleInRadians: CGFloat?, rotateAction: SKAction?
        
        switch direction {
        case .left:
            angleInRadians = self.turningSpeed!
            rotateAction = SKAction.rotate(byAngle: angleInRadians!, duration: 0)
        case .right:
            angleInRadians = -self.turningSpeed!
            rotateAction = SKAction.rotate(byAngle: angleInRadians!, duration: 0)
        }
        
        // rotate car
        self.node?.run(rotateAction!)
    
        // rotate camera
        let rotateCamAction = SKAction.rotate(byAngle: angleInRadians!, duration: 1.4)
        self.scene.cameraNode?.run(rotateCamAction)
        
        // update moving vector
        movingVector = CGVector(dx: cos(self.node!.zRotation) * maxSpeed!, dy: sin(self.node!.zRotation) * maxSpeed!)

        
    }

    func driveForward() {
    
        self.node?.physicsBody?.velocity.dx = cos(self.node!.zRotation) * 100
        self.node?.physicsBody?.velocity.dy = sin(self.node!.zRotation) * 100

//        print("velocity: ", self.node?.physicsBody?.velocity)
        // camera follow driving car
        self.scene.cameraNode?.position = (self.node!.position)
        
        self.isDriving = true
    }
    
    func driveBackward() {
        
        self.node?.physicsBody?.velocity.dx = -cos(self.node!.zRotation) * 80
        self.node?.physicsBody?.velocity.dy = -sin(self.node!.zRotation) * 80
        
        
        
        // camera follow driving car
        self.scene.cameraNode?.position = (self.node!.position)
        
        self.isDriving = true
    }
    
    func stopDriving() {
        self.node?.physicsBody?.velocity.dx = 0
        self.node?.physicsBody?.velocity.dy = 0
    }

}
