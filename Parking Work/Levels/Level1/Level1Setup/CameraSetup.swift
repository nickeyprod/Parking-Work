//
//  CameraSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 14.02.2023.
//

import SpriteKit

// Level 1 Camera Setup
extension Level1 {
    /// Get camera node from game scene and set its position to the same place as player position.
    func setupCamera() {
//        let mb = childNode(withName: "mysor_bak_2")
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        cameraNode?.position = (player?.node!.position)!
//        cameraNode?.position = (mb?.position)!
        // remember initial camera rotation
        initialCameraRotation = self.cameraNode?.zRotation
    }
    
}
