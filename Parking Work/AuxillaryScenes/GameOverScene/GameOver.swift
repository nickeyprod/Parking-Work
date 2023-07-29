//
//  GameOver.swift
//  Parking Work
//
//  Created by Николай Ногин on 17.03.2023.
//

import SpriteKit
import Foundation
import GameplayKit

class GameOver: ParkingWorkGame {
    let messages: [String] = [
        "Копы взяли тебя, игра окончена.",
        "Игра окончена, кто-то вызвал копов.",
        "Тебя застали за угоном, игра окончена.",
        "Теперь тебя отправят в участок, игра окончена."
    ]
    
    let carBumpMessages: [String] = [
        "Так смело ходить по проезжей части?",
        "Так можно и на тот свет отправиться!",
        "Скорая уже выехала...",
        "Всегда рассчитывай только на себя и свою внимательность!",
        "Всегда лучше смотреть по сторонам..."
    ]
    var backgroundImg: SKSpriteNode?
    var catchedHeader: SKLabelNode?
    var message: SKLabelNode?
    var restartBtn: SKSpriteNode?
    var restartBtnLabel: SKLabelNode?
    var type: String = "catched"
    
    var animateBackgroundTimer: Timer?
    
    override func didMove(to view: SKView) {
        
       
        // initial variables
        setupInitialGameValues()
        
        // creating upper popup for messages
        createUpperPopUp()
        
        // save game progress
        saveGameProgress()
        
        if type == "carBump" {
            let bumpedImg = self.childNode(withName: "background2") as? SKSpriteNode
            bumpedImg?.alpha = 1
            let catchedImg = self.childNode(withName: "background") as? SKSpriteNode
            catchedImg?.alpha = 0
        } else {
            let catchedImg = self.childNode(withName: "background") as? SKSpriteNode
            catchedImg?.alpha = 1
            let bumpedImg = self.childNode(withName: "background2") as? SKSpriteNode
            bumpedImg?.alpha = 0
            
        }
        
        backgroundImg?.size.width = displayWidth! + displayWidth! / 3
        backgroundImg?.size.height = displayHeight! + displayHeight! / 3
        backgroundImg?.run(.scale(to: 0.8, duration: 0.05), completion: {
            self.backgroundImg?.run(.scaleX(to: 1.7, duration: 6.0))
            self.backgroundImg?.run(.scaleY(to: 1.6, duration: 6.0))
            self.animateBackground()
            self.backgroundImg?.run(.move(by: CGVector(dx: -55.0, dy: 20), duration: 6.0), completion: {
                self.animateBackgroundTimer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true, block: { _ in
                    self.animateBackground()
                })
                
            })
        })
        
        self.catchedHeader = self.childNode(withName: "catched-header") as? SKLabelNode
        self.catchedHeader?.fontColor = .red
        self.catchedHeader?.fontSize = 44
        self.catchedHeader?.fontName = "Baskerville-bold"
        
        if type == "carBump" {
            self.catchedHeader?.text = "Cбит"
        }
        
        self.restartBtn = self.childNode(withName: "restart-btn-rect") as? SKSpriteNode
        self.restartBtnLabel = self.childNode(withName: "restart-btn-label") as? SKLabelNode
        
        self.message = self.childNode(withName: "message") as? SKLabelNode
        
        message?.text = messages.randomElement() ?? "Копы взяли тебя, игра окончена."
        
        if type == "carBump" {
            message?.text = carBumpMessages.randomElement() ?? "Роботы за рулем только в будущем..."
        }
       
    }
    
    func animateBackground() {
  
        if backgroundImg!.xScale > 1.6  {
            self.backgroundImg?.run(.scaleX(to: 1.5, duration: 6.0))
            self.backgroundImg?.run(.scaleY(to: 1.2, duration: 6.0))
        } else {
            self.backgroundImg?.run(.scaleX(to: 1.7, duration: 6.0))
            self.backgroundImg?.run(.scaleY(to: 1.4, duration: 6.0))
        }
                                
        self.backgroundImg?.run(.move(by: CGVector(dx: -55.0, dy: 20), duration: 6.0), completion: {
            self.backgroundImg?.run(.move(by: CGVector(dx: 55.0, dy: -20), duration: 6.0))
        })

    }
    
    override func setupInitialGameValues() {
        // get display width and height
        displayWidth = displaySize.width
        displayHeight = displaySize.height
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // buttons pressed check
            let touchedNode = atPoint(location)
            if touchedNode.name == "restart-btn-rect" || touchedNode.name == "restart-btn-label" {
                restartGame()
            }
        }
    }
    
    func restartGame() {
       
        let currMissionScene = GKScene(fileNamed: "Mission\(missionNum)Scene")?.rootNode as! ParkingWorkGame
        
        let transition = SKTransition.fade(with: .black, duration: 1.0)
        self.removeAllActions()
        self.backgroundImg?.removeAllActions()
        animateBackgroundTimer?.invalidate()
        
        currMissionScene.player = player
        currMissionScene.missionNum = missionNum
        currMissionScene.gameLoaded = gameLoaded
        currMissionScene.tutorialEnded = tutorialEnded
        
        let displaySize: CGRect = UIScreen.main.bounds
        // Set the scale mode to scale to fit the window
        currMissionScene.scaleMode = .aspectFill
        currMissionScene.size = displaySize.size
        
        // on/off tutorial when restart according to saved state
        self.setTutorial()
        
        self.view?.presentScene(currMissionScene, transition: transition)
    }
   
}
