//
//  CameraSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 14.02.2023.
//

import SpriteKit

// Camera Setup
extension ParkingWorkGame {
    /// Get camera node from game scene and set its position to the same place as player position.
    func setupCamera() {
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        cameraNode?.position = player!.position
    }
}
