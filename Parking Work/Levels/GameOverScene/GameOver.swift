//
//  GameOver.swift
//  Parking Work
//
//  Created by Николай Ногин on 17.03.2023.
//

import SpriteKit

class GameOverScene: ParkingWorkGame {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupInitialGameValues()
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
            if touchedNode.name == "restart-btn"  {
                
                restartGame()
            }
        }
    }

    func restartGame() {
        print("restart game")
        
//        let level1Scene = SKScene(fileNamed: "Level1Scene")
//        let transition = SKTransition.fade(with: .black, duration: 1.0)
//        let displaySize: CGRect = UIScreen.main.bounds
//        // Set the scale mode to scale to fit the window
//        level1Scene?.scaleMode = .aspectFill
//        level1Scene?.size = displaySize.size
//        self.view?.presentScene(level1Scene!, transition: transition)
    }
}
