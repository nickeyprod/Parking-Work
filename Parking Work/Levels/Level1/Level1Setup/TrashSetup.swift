//
//  TrashSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 17.04.2023.
//

import SpriteKit

// Level 1 Cars Setup
extension Level1 {
    
    func addTRASH(_ texture: SKTexture, how: String) {
      let sprite = SKSpriteNode(texture: texture)

      sprite.physicsBody = SKPhysicsBody(texture: texture, size: sprite.size)
      if sprite.physicsBody == nil {
        print("\(how) failed")
      } else {
        print("\(how) worked")
      }
//      addChild(sprite)
    }
    
    func setupTrashcans() {
        
        // player collides with this `end of the world` boundaries
        for i in 0...3 {
//            let trashBak = childNode(withName: "mysor_bak_\(i)")
//            let texture = SKTexture(imageNamed: "Mysor_Bak_2")
//
//            let renderedTexture = view!.texture(from: SKSpriteNode(texture: texture))!
//            trashBak?.physicsBody = SKPhysicsBody(texture: renderedTexture, size: CGSize(width: 167.184, height: -171.372))
//
//            trashBak?.physicsBody?.affectedByGravity = false
//            trashBak?.physicsBody?.isDynamic = false
//
            // The atlas version of a texture
//            addTRASH(SKTexture(imageNamed: "Mysor_Bak_2"), how: "simple atlas reference")
//            // From an atlas, but call size() to force loading
//            let texture = SKTexture(imageNamed: "Mysor_Bak_2")
//            _ = texture.size()
//            addTRASH(texture, how: "atlas force load")
//            // Reconstruct via CGImage (size would be wrong because of 2x)
//            let cgTexture = SKTexture(cgImage: texture.cgImage())
//            addTRASH(cgTexture, how: "reconstruct via cgImage")
//            // Re-render using view
//            let renderedTexture = view?.texture(from: SKSpriteNode(texture: texture))!
//            addTRASH(renderedTexture!, how: "re-render using view")
//            // Non-atlas texture
//            addTRASH(SKTexture(imageNamed: "Mysor_Bak_2"), how: "not in atlas")
        }
     
    }

}
