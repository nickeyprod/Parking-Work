//
//  CarsSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// Level 1 Cars Setup
extension Level1 {
    func setupCars() {
        
        // Old Copper
        oldCopper.node = childNode(withName: CAR_TEXTURE_NAMES.oldCopper)
        oldCopper.node?.userData = NSMutableDictionary()
        oldCopper.node?.userData?.setValue(oldCopper.self, forKeyPath: "self")
        oldCopper.node?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.oldCopper), size: CGSize(width: 460, height: 200))
        oldCopper.node?.physicsBody?.categoryBitMask = carCategory
        oldCopper.node?.physicsBody?.affectedByGravity = false
        oldCopper.node?.physicsBody?.isDynamic = false
        oldCopper.node?.zPosition = 1

        // Chowerler
        chowerler.node = childNode(withName: CAR_TEXTURE_NAMES.chowerler)
        chowerler.node?.userData = NSMutableDictionary()
        chowerler.node?.userData?.setValue(chowerler.self, forKeyPath: "self")
        chowerler.node?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.chowerler), size: CGSize(width: 258.363, height: 506.244))

        chowerler.node?.physicsBody?.categoryBitMask = carCategory
        chowerler.node?.physicsBody?.affectedByGravity = false
        chowerler.node?.physicsBody?.isDynamic = false
        chowerler.node?.zPosition = 1
    }

}
