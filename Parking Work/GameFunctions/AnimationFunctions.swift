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
    
    func throwItem(item: SKNode) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 40))
        path.addLine(to: CGPoint(x: 10, y: 60))
        path.addLine(to: CGPoint(x: 20, y: 70))
        path.addLine(to: CGPoint(x: 30, y: 80))
        path.addLine(to: CGPoint(x: 40, y: 90))
        
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: false, speed: 150)
        
        item.run(.rotate(byAngle: -20, duration: 2))
        item.run(.scale(to: 0.0, duration: 1)) {
            item.removeFromParent()
        }
        item.run(move)
        
    }
    
    func animateShopItem(itemNode: SKSpriteNode) {
        
        let scaleAction = SKAction.sequence([.scale(to: 0.80, duration: 0.1), .scale(to: 1.0, duration: 0.1)])
        
        itemNode.run(scaleAction) {
            let scaleAction = SKAction.sequence([.scale(to: 1.05, duration: 0.8), .scale(to: 1.0, duration: 0.8)])
            
            let initialPosY = itemNode.position.y
            let moveUpDownAction = SKAction.sequence([.moveTo(y: -20, duration: 0.8),
                                                      .moveTo(y: initialPosY, duration: 0.8)])
            
            let rotateAction = SKAction.sequence([.rotate(toAngle: 0.05, duration: 1.2), .rotate(toAngle: 0, duration: 1.2)])
            
            itemNode.run(.repeatForever(scaleAction), withKey: "scale-anim")
            itemNode.run(.repeatForever(moveUpDownAction), withKey: "move-anim")
            itemNode.run(.repeatForever(rotateAction), withKey: "rotate-anim")
        }
        
    }
    
    func animateShopBuyButton(button: SKSpriteNode) {
        
//        button.color = .gray
        
//        let buttonText = button.childNode(withName: "ui-buy-button-label") as? SKLabelNode
//        buttonText?.text = "Нет денег"
        

        
        let scaleAction = SKAction.sequence([.scale(to: 0.94, duration: 0.8), .scale(to: 1.0, duration: 0.4)])
        
        let alphaAction = SKAction.sequence([.fadeAlpha(to: 0.6, duration: 0.8), .fadeAlpha(to: 0.9, duration: 0.4)])
        
        
        button.run(.repeatForever(scaleAction))
        button.run(.repeatForever(alphaAction))
        
       
    }
    
    func animateButtonClick(button: SKSpriteNode, done: (() -> Void)? ) {
        let scaleAction = SKAction.sequence([.scale(to: 0.80, duration: 0.1), .scale(to: 1.0, duration: 0.1)])
        button.run(scaleAction) {
            done?()
        }
        
    }
    
    func animateStartButton(button: SKSpriteNode) {
        button.run(SKAction.repeatForever(.sequence([SKAction.fadeAlpha(to: 0.6, duration: 2.0), SKAction.fadeAlpha(to: 1.0, duration: 2.0)])))
        button.run(SKAction.repeatForever(.sequence([SKAction.scale(to: 1.05, duration: 1.0), SKAction.scale(to: 1.0, duration: 0.6)])))
    }
    
    
}
