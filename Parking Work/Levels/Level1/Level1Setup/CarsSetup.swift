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
        
        oldCopper = Car(scene: self, name: CarNameList.OldCopper.rawValue, maxSpeed: 100, turningSpeed: 0.006)
        chowerler = Car(scene: self, name: CarNameList.Chowerler.rawValue, maxSpeed: 16, turningSpeed: 0.012)
        
        // Old Copper
        oldCopper!.node = childNode(withName: CAR_TEXTURE_NAMES.oldCopper) as? SKSpriteNode
        oldCopper!.node?.userData = NSMutableDictionary()
        oldCopper!.node?.userData?.setValue(oldCopper.self, forKeyPath: "self")
        oldCopper!.node?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.oldCopper), size: CGSize(width: 460, height: 200))
        
        oldCopper!.node?.physicsBody?.categoryBitMask = carCategory
        oldCopper!.node?.physicsBody?.collisionBitMask = boundaryCategory | carCategory | playerCategory
        oldCopper!.node?.physicsBody?.affectedByGravity = false
        oldCopper!.node?.physicsBody?.isDynamic = true
        oldCopper!.node?.zPosition = 2
        oldCopper!.node?.anchorPoint = CGPoint(x: 0.45, y: 0.5)
    
        // Chowerler
        chowerler!.node = childNode(withName: CAR_TEXTURE_NAMES.chowerler) as? SKSpriteNode
        chowerler!.node?.userData = NSMutableDictionary()
        chowerler!.node?.userData?.setValue(chowerler.self, forKeyPath: "self")
        chowerler!.node?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: CAR_TEXTURE_NAMES.chowerler), size: CGSize(width: 440, height: 220))
        chowerler!.node?.physicsBody?.collisionBitMask = boundaryCategory | carCategory

        chowerler!.node?.physicsBody?.categoryBitMask = carCategory
        chowerler!.node?.physicsBody?.affectedByGravity = false
        chowerler!.node?.physicsBody?.isDynamic = true
        chowerler!.node?.anchorPoint = CGPoint(x: 0.48, y: 0.495)
        chowerler!.node?.zPosition = 2
        
    }

}
