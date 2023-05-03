//
//  AnimationFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 03.05.2023.
//

import SpriteKit

// Custom Animations Functions
extension ParkingWorkGame {
    
    // blinks anxiety bar
    func hightLightAnxietyBar() {
        if self.anxietyLevel >= 110.0 {
            self.anxietyOuterShape?.strokeColor = Colors.DangerStrokeRed
            self.anxietyInnerSprite?.color = .black
            
            if !animatedAnxietyFirst {
                animatedAnxietyFirst = true
                self.anxietyOuterShape?.run(SKAction.scale(to: 1.2, duration: 0.2), completion: {
                    self.anxietyOuterShape?.setScale(1.0)
                })
            }
            
        } else if self.anxietyLevel > 70.0 && self.anxietyLevel <= 110.0 {
            if !animatedAnxietySecond {
                self.animatedAnxietySecond = true
                self.anxietyOuterShape?.run(SKAction.scale(to: 1.2, duration: 0.2), completion: {
                    self.anxietyOuterShape?.setScale(1.0)
                })
            }

            self.anxietyOuterShape?.strokeColor = .white
            self.anxietyInnerSprite?.color = .blue
        } else {
            self.animatedAnxietyFirst = false
            self.animatedAnxietySecond = false
            self.anxietyOuterShape?.strokeColor = .white
            self.anxietyInnerSprite?.color = .systemBlue
        }
    }
    
    // rolling some text as banner message at the center of the screens
    func showBannerLabel(text: String) {
        let levelNumberNode = self.cameraNode?.childNode(withName: "LevelNumberNode")
        let levelLabelNode = levelNumberNode?.childNode(withName: "LevelLabelNode") as? SKLabelNode
        levelLabelNode?.run(SKAction.fadeIn(withDuration: 0.8))
        
        levelLabelNode?.text = text
        let act = SKAction.resize(toWidth: displayWidth!, duration: 0.3)
        levelNumberNode?.run(act)
        
        levelLabelNode?.run(SKAction.scale(to: 1.2, duration: 0.4), completion: {
            levelLabelNode?.run(SKAction.scale(to: 1.0, duration: 0.15))
            // roll back and hide
            Timer.scheduledTimer(withTimeInterval: 2.2, repeats: false) { _ in
                let act = SKAction.resize(toWidth: 0, duration: 0.6)
                levelNumberNode?.run(act)
                levelLabelNode?.run(SKAction.fadeOut(withDuration: 0.5))

                levelLabelNode?.run(SKAction.scale(to: 1.2, duration: 0.2))
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    levelLabelNode?.run(SKAction.scale(to: 1.0, duration: 0.15))
                }
            }
        })
    }
    
}
