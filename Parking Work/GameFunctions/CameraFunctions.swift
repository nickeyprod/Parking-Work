//
//  CameraFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

// Camera Control Game Functions
extension ParkingWorkGame {
    
    // Zooming Out
    func zoomOutCamera(to num: CGFloat, usual: Bool = false) {
        
        let act = SKAction.scale(by: num, duration: 2.0)
        let act2 = SKAction.sequence([act, SKAction.wait(forDuration: 1.5)])
        cameraNode?.run(act2, completion: {
            // zoom out back to min scale if it is at the start of the level
            if usual != true {
                self.cameraNode?.run(SKAction.scale(to: self.minScale, duration: 0.7))
            }
            
        })
    }
    
}
