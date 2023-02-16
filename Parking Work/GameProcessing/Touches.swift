//
//  TouchesExtension.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Touches processing
extension ParkingWorkGame {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in: self)
            if startTouchPosition == nil {
                startTouchPosition = location
            }
            
            // buttons pressed check
            let touchedNode = atPoint(location)
            if touchedNode.name == "yesOpenLockBtn" || touchedNode.parent?.name == "yesOpenLockBtn" {
                print("open car button pressed")
            } else if touchedNode.name == "noOpenLockBtn" || touchedNode.parent?.name == "noOpenLockBtn" {
                print("no open car button pressed")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        cameraMovingByFinger = true
        
        for touch in touches {
            let location = touch.location(in: self)
            
            currTouchPosition = CGPoint(x: location.x, y: location.y)
            
            // movig camera logic
            if currTouchPosition != nil && startTouchPosition != nil {
                
                let diffX = startTouchPosition!.x - currTouchPosition!.x
                let diffY = startTouchPosition!.y - currTouchPosition!.y
                cameraNode?.position.x = (cameraNode?.position.x)! + diffX
                cameraNode?.position.y = (cameraNode?.position.y)! + diffY
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startTouchPosition = nil
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            if cameraMovingByFinger == false && !isTouchingOpenCarWindow(touchedNode: touchedNode) {
                playerLocationDestination = location
                currentSpriteTarget?.removeFromParent()
                setTarget(at: location)
            }
            
            cameraMovingByFinger = false
            
            
        }
    }
    
    func setTarget(at location: CGPoint) {
        
        // setting 'target' sprite on ground
        currentSpriteTarget = SKSpriteNode(imageNamed: "target")
        currentSpriteTarget!.position = location
        currentSpriteTarget!.xScale = 0.2
        currentSpriteTarget!.yScale = 0.2
        currentSpriteTarget?.zPosition = 0
        currentSpriteTarget?.colorBlendFactor = 0.4
        addChild(currentSpriteTarget!)
        
        targetRotate(target: currentSpriteTarget!)
    }
    
    func targetRotate(target: SKSpriteNode) {
        var angle = 1.14
        var rotatingAction = SKAction.rotate(byAngle: angle, duration: 1.0)
        target.run(rotatingAction)
        
        targetMovementTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            angle = -angle
            rotatingAction = SKAction.rotate(byAngle: angle, duration: 1.0)
            target.removeAllActions()
            target.run(rotatingAction)
        }
    }
    
    func isTouchingOpenCarWindow(touchedNode: SKNode) -> Bool {
        let openCarWindowNodesNames = [
            "openCarMessageWindow",
            "carNameLabel",
            "carMessageLabel",
            "lockTypeLabel",
            "yesOpenLockBtn",
            "noOpenLockBtn",
            "yesBtnLabel",
            "noBtnLabel",
            "complexityLabel",
            "complexityNumLevel"
        ]
        
        var isTouchingOpenCarWindow = false
        
        for nodeName in openCarWindowNodesNames {
            if touchedNode.name == nodeName {
                isTouchingOpenCarWindow = true
            }
        }
        return isTouchingOpenCarWindow
    }

}

