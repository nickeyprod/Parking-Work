//
//  LevelCompletion.swift
//  Parking Work
//
//  Created by Николай Ногин on 25.05.2023.
//

import SpriteKit
import GameplayKit

class LevelCompletion: ParkingWorkGame {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // setup intial variables
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
            print("touch")
        }
    }
    
}
