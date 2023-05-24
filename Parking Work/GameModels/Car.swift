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
    var engineStartsSound: SKAudioNode?
    var engineAcceleratingSound: SKAudioNode?
    var engineDrivingSound: SKAudioNode?
    
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
    var isAccelerating: Bool = false
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
    // driving power cannot be more than 100%
    var currDrivingPower: CGFloat?

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
            angleInRadians = turningSpeed! * (currDrivingPower! / 100)
            rotateAction = SKAction.rotate(byAngle: angleInRadians!, duration: 0)
        case .right:
            angleInRadians = -turningSpeed! * (currDrivingPower! / 100)
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
        isAccelerating = true

        currSpeed! += accelerationRate! + secondaryAcceleration!
        secondaryAcceleration! = secondaryAcceleration! * 0.5

        if back == true {
            // moving back with current speed
            moveWithCurrSpeed(negative: true)
            
            // set to true because when speed more than speed backward, we just set speed backward to max speed back and continuing driving back
            continueBackward = true
        }
        else {
            // just moving with current speed
            moveWithCurrSpeed()
        }
    }

    func driveForward() {
        
        // curr driving power needed for calculating strength of turning
        currDrivingPower = currSpeed! / maxSpeedForward! * 100
        
        isDrivingForward = true; isDrivingBackward = false
        continueBackward = false
        
        if currSpeed! <= maxSpeedForward! {
            // car accelerating
            accelerate(back: false)
        } else {
            // car driving on max speed
            isAccelerating = false
            
            // reset secondary acceleration
            resetSecondaryAcceleration()
            
            // set speed to max speed forward
            self.setSpeedForwardToMax()
        }

        // camera follow driving car
        self.scene.cameraNode?.position = (self.node!.position)
        
        // playing sound
        if isAccelerating {
            emitEngineAcceleratingSound()
        } else {
            emitEngineDrivingSound()
        }
    }
    
    func driveBackward() {
        
        // curr driving power needed for calculating strength of turning
        currDrivingPower = currSpeed! / maxSpeedBackward! * 100
        
        isDrivingForward = false; isDrivingBackward = true

        // slowly increase backward speed
        if currSpeed! <= maxSpeedBackward!{
            accelerate(back: true)
        } else {
            // car has finished acceleration
            isAccelerating = false
            
            // reset secondary acceleration rate
            resetSecondaryAcceleration()
            
            // continue backward means brake button still holded
            if currSpeed! > maxSpeedBackward! && continueBackward == false {
                
                // player brakes -> speed slowly decreases
                currSpeed! -= brakeRate! + secondaryAcceleration!
                
                // move car with it's current speed
                moveWithCurrSpeed()
            } else {
                // else just drive back with max backward speed
                setSpeedBackwardToMax()
            }
            
        }
        
        // camera follow driving car
        self.scene.cameraNode?.position = (self.node!.position)
        
        // playing sound
        if isAccelerating {
            emitEngineAcceleratingSound()
        } else {
            emitEngineDrivingSound()
        }
    }
    
    func stopDriving() {
        
        // curr driving power needed for calculating strength of turning
        if isDrivingForward {
            currDrivingPower = currSpeed! / maxSpeedForward! * 100
        } else if isDrivingBackward {
            currDrivingPower = currSpeed! / maxSpeedBackward! * 100
        }
        
        // stop sounds
        engineDrivingSound?.run(.stop())
        engineAcceleratingSound?.run(.stop())
        
        if currSpeed! > self.initialSpeed! {
            self.currSpeed! -= accelerationRate!
            if isDrivingForward {
                // moving forward with current speed
                moveWithCurrSpeed()
            }
            if isDrivingBackward {
                // moving back with current speed
                moveWithCurrSpeed(negative: true)
            }
            
        }
        // camera follow driving car
        self.scene.cameraNode?.position = (self.node!.position)
    }
    
    func emitEngineAcceleratingSound() {
        if engineAcceleratingSound == nil {
            engineAcceleratingSound = node?.childNode(withName: EngineSound.old_copper_acceleration.rawValue) as? SKAudioNode
            engineStartsSound?.autoplayLooped = false
        }
        engineAcceleratingSound?.run(.play())
    }
    
    func emitEngineDrivingSound() {
        if engineDrivingSound == nil {
            engineDrivingSound = node?.childNode(withName: EngineSound.old_copper_driving.rawValue) as? SKAudioNode
            engineDrivingSound?.autoplayLooped = false
        }
        engineDrivingSound?.run(.play())
    }
    
    func setSpeedForwardToMax() {
        self.node?.physicsBody?.velocity.dx = cos(self.node!.zRotation) * maxSpeedForward!
        self.node?.physicsBody?.velocity.dy = sin(self.node!.zRotation) * maxSpeedForward!
    }
    
    func setSpeedBackwardToMax() {
        self.node?.physicsBody?.velocity.dx = -cos(self.node!.zRotation) * maxSpeedBackward!
        self.node?.physicsBody?.velocity.dy = -sin(self.node!.zRotation) * maxSpeedBackward!
    }
    
    func resetSecondaryAcceleration() {
        self.secondaryAcceleration = initialSecondaryAcceleration
    }
    
    func moveWithCurrSpeed(negative: Bool? = false) {
        if negative == true {
            self.node?.physicsBody?.velocity.dx = -cos(self.node!.zRotation) * currSpeed!
            self.node?.physicsBody?.velocity.dy = -sin(self.node!.zRotation) * currSpeed!
        } else {
            self.node?.physicsBody?.velocity.dx = cos(self.node!.zRotation) * currSpeed!
            self.node?.physicsBody?.velocity.dy = sin(self.node!.zRotation) * currSpeed!
        }
    }

}
