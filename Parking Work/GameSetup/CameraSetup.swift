//
//  CameraSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 14.02.2023.
//

import SpriteKit

// Game Camera Setup
extension ParkingWorkGame {
    func setupCamera() {
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        cameraNode?.position = player?.node?.position ?? CGPoint(x: 0, y: 0)

        // remember initial camera rotation
        initialCameraRotation = self.cameraNode?.zRotation
    }
}
