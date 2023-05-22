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
    
    init(scene: SKScene, name: String, initialSpeed: CGFloat, maxSpeedForward: CGFloat, maxSpeedBackward: CGFloat, turningSpeed: CGFloat, accelerationRate: CGFloat, secondaryAcceleration: CGFloat, brakeRate: CGFloat) {
        self.scene = (scene as? ParkingWorkGame)!
        self.name = name
        self.currSpeed = initialSpeed
        self.initialSpeed = initialSpeed
        self.maxSpeedForward = maxSpeedForward
        self.maxSpeedBackward = maxSpeedBackward
        self.turningSpeed = turningSpeed
        self.accelerationRate = accelerationRate
        self.secondaryAcceleration = secondaryAcceleration
        self.initialSecondaryAcceleration = secondaryAcceleration
        self.brakeRate = brakeRate
    }
    
    let scene: ParkingWorkGame
    
    // car name
    let name: String
    
    // car sound
    var engineStarts: SKAction?
    var engineAccelerating: SKAudioNode?
    var engineDriving: SKAudioNode?
    
    // locks list
    var locks: [String: Float?] = [
        "driver_lock": nil,
        "passenger_lock": nil,
        ]
    
    var jammedLocks: [String?] = []
    
    // other variables
    var signaling: Bool = false
    var stolen: Bool = false
    var isDrivingForward: Bool = false
    var isDrivingBackward: Bool = false
    var isPrevMovementForward: Bool = false
    var continueBackward: Bool = false
    
    var currDrivingPoint: CGPoint?
    var movingVector: CGVector?
    
    var maxSpeedForward: CGFloat?
    var maxSpeedBackward: CGFloat?
    var turningSpeed: CGFloat?
    var currSpeed: CGFloat?
    var initialSpeed: CGFloat?
    var accelerationRate: CGFloat?
    var secondaryAcceleration: CGFloat?
    var initialSecondaryAcceleration: CGFloat?
    var brakeRate: CGFloat?

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
        let currMaxSpeed = isDrivingForward ? maxSpeedForward : maxSpeedBackward
        movingVector = CGVector(dx: cos(self.node!.zRotation) * currMaxSpeed!, dy: sin(self.node!.zRotation) * currMaxSpeed!)

        
    }
    
    func accelerate(back: Bool) {

        currSpeed! += accelerationRate! + secondaryAcceleration!
        secondaryAcceleration! = secondaryAcceleration! * 0.5
        if back == true {
            self.node?.physicsBody?.velocity.dx = -cos(self.node!.zRotation) * currSpeed!
            self.node?.physicsBody?.velocity.dy = -sin(self.node!.zRotation) * currSpeed!
            // set to true because when speed more than speed backward, we just set speed backward to max speed back and continuing driving back
            continueBackward = true
        }
        else {
            self.node?.physicsBody?.velocity.dx = cos(self.node!.zRotation) * currSpeed!
            self.node?.physicsBody?.velocity.dy = sin(self.node!.zRotation) * currSpeed!
        }

        
    }

    func driveForward() {
        isDrivingForward = true; isDrivingBackward = false
        continueBackward = false
        
        if currSpeed! <= maxSpeedForward!{
            accelerate(back: false)
        } else {
            self.secondaryAcceleration = initialSecondaryAcceleration
            self.node?.physicsBody?.velocity.dx = cos(self.node!.zRotation) * maxSpeedForward!
            self.node?.physicsBody?.velocity.dy = sin(self.node!.zRotation) * maxSpeedForward!
        }

        // camera follow driving car
        self.scene.cameraNode?.position = (self.node!.position)
    }
    
    func driveBackward() {
        
        isDrivingForward = false; isDrivingBackward = true

        // slowly increase backward speed
        if currSpeed! <= maxSpeedBackward!{
            accelerate(back: true)
        } else {
            // continue backward means brake button holded
            if currSpeed! > maxSpeedBackward! && continueBackward == false {
                
                // player brakes -> speed slowly decreases
                currSpeed! -= brakeRate! + secondaryAcceleration!

                self.secondaryAcceleration = initialSecondaryAcceleration
                self.node?.physicsBody?.velocity.dx = cos(self.node!.zRotation) * currSpeed!
                self.node?.physicsBody?.velocity.dy = sin(self.node!.zRotation) * currSpeed!
            } else {
                self.secondaryAcceleration = initialSecondaryAcceleration
                self.node?.physicsBody?.velocity.dx = -cos(self.node!.zRotation) * maxSpeedBackward!
                self.node?.physicsBody?.velocity.dy = -sin(self.node!.zRotation) * maxSpeedBackward!
            }
            
        }
    
        
    
    
        
    
        
        // camera follow driving car
        self.scene.cameraNode?.position = (self.node!.position)
    }
    
    func stopDriving() {
        if currSpeed! > self.initialSpeed! {
            self.currSpeed! -= accelerationRate!
            if isDrivingForward {
                self.node?.physicsBody?.velocity.dx = cos(self.node!.zRotation) * currSpeed!
                self.node?.physicsBody?.velocity.dy = sin(self.node!.zRotation) * currSpeed!
            }
            if isDrivingBackward {
                self.node?.physicsBody?.velocity.dx = -cos(self.node!.zRotation) * currSpeed!
                self.node?.physicsBody?.velocity.dy = -sin(self.node!.zRotation) * currSpeed!
            }
            
        }
        // camera follow driving car
        self.scene.cameraNode?.position = (self.node!.position)
    }

}
