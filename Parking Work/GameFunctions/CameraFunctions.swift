//
//  CameraFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

// Camera Control Game Functions
extension ParkingWorkGame {
    
    // Zooming Out and then in animation for the start of the mission
    func zoomOutInCameraAnimation(to num: CGFloat) {
        
        let act = SKAction.scale(by: num, duration: 2.0)
        let act2 = SKAction.sequence([act, SKAction.wait(forDuration: 1.5)])
        cameraNode?.run(act2, completion: {
            self.cameraNode?.run(SKAction.scale(to: self.minScale + 0.20, duration: 0.7))
        })
    }
    
    // Zooming camera to specific number with animation
    func zoomCamera(to num: CGFloat, duration: CGFloat = 0) {
        self.cameraNode?.run(SKAction.scale(to: num, duration: duration))
    }
    
}
