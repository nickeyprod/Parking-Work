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
            self.anxietyOuterShape?.strokeColor = COLORS.DangerStrokeRed
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
        let missionNumberNode = self.cameraNode?.childNode(withName: "MissionNumberNode")
        let missionLabelNode = missionNumberNode?.childNode(withName: "MissionLabelNode") as? SKLabelNode
        missionLabelNode?.run(SKAction.fadeIn(withDuration: 0.8))
        
        missionLabelNode?.text = text
        let act = SKAction.resize(toWidth: displayWidth!, duration: 0.3)
        missionNumberNode?.run(act)
        
        missionLabelNode?.run(SKAction.scale(to: 1.2, duration: 0.4), completion: {
            missionLabelNode?.run(SKAction.scale(to: 1.0, duration: 0.15))
            // roll back and hide
            Timer.scheduledTimer(withTimeInterval: 2.2, repeats: false) { _ in
                let act = SKAction.resize(toWidth: 0, duration: 0.6)
                missionNumberNode?.run(act)
                missionLabelNode?.run(SKAction.fadeOut(withDuration: 0.5))

                missionLabelNode?.run(SKAction.scale(to: 1.2, duration: 0.2))
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    missionLabelNode?.run(SKAction.scale(to: 1.0, duration: 0.15))
                }
            }
        })
    }
    
}
