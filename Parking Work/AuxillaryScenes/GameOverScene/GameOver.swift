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
    var backgroundImg: SKSpriteNode?
    var catchedHeader: SKLabelNode?
    var message: SKLabelNode?
    var restartBtn: SKSpriteNode?
    var restartBtnLabel: SKLabelNode?
    
    var animateBackgroundTimer: Timer?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupInitialGameValues()
        
        backgroundImg = self.childNode(withName: "background") as? SKSpriteNode
        
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
        
        self.restartBtn = self.childNode(withName: "restart-btn-rect") as? SKSpriteNode
        self.restartBtnLabel = self.childNode(withName: "restart-btn-label") as? SKLabelNode
        
        self.message = self.childNode(withName: "message") as? SKLabelNode
        
        message?.text = messages.randomElement() ?? "Копы взяли тебя, игра окончена."
       
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
        
        let displaySize: CGRect = UIScreen.main.bounds
        // Set the scale mode to scale to fit the window
        currMissionScene.scaleMode = .aspectFill
        currMissionScene.size = displaySize.size
        
        // off tutorial when restart
        self.tutorial(set: false)
        
        self.view?.presentScene(currMissionScene, transition: transition)
    }
   
    deinit {
        print("GameOver deinit")
    }
}
