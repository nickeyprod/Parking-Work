//
//  GamePlayFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 13.02.2023.
//

import SpriteKit

// General Game Functions
extension ParkingWorkGame {
    
    // this updates position of the player on minimap
    func updateMiniMapPlayerPos() {

        let scaleWidthFactor = tileMapWidth! / miniMapWidth!
        let scaleHeightFactor = tileMapHeight! / miniMapHeight!

        let miniMapX = player!.node!.position.x / scaleWidthFactor * miniMapScaleFactor
        let minimapY = player!.node!.position.y / scaleHeightFactor * miniMapScaleFactor
        
        miniMapSprite?.position = CGPoint(x: -miniMapX, y: -minimapY)
    }

    
    func checkDistanceBetweenPlayerAndTargetLock() {
        let playerPosition = player?.node?.position
        let targetCarPosition = player?.currLockTarget?.parent?.position
        
        let diffX = abs(playerPosition!.x) - abs(targetCarPosition!.x)
        let diffY = abs(playerPosition!.y) - abs(targetCarPosition!.y)

        if (abs(diffX) > 150 || abs(diffY) > 150) {
            if player?.currTargetCar?.stolen == true {
                self.enterToCarBtn?.removeFromParent()
                self.enterToCarBtn = nil
            } else {
                hideOpenCarMessage()
            }
            
        }
        // lock target clearing
        if (abs(diffX) > 420 || abs(diffY) > 420) {
            player?.currLockTarget = nil
            player!.currTargetCar = nil
            hideTargetSquare()
        }
    
    }
    
    // rising anxiety bar (144max)
    func raiseAnxiety(to num: CGFloat) {
        // do not raise anxiety during showing tutorial messages
        if canMoveCamera == false || player!.isSittingInCar { return }
        
        canReduceAnxiety = false
        
        let futureWidth = anxietyLevel + num
        
        if futureWidth > 144.0 {
            anxietyLevel = 144
        } else {
            anxietyLevel = futureWidth
        }
        anxietyBar!.run(SKAction.resize(toWidth: anxietyLevel, duration: 0.2)) {
            self.canReduceAnxiety = true
        }
    }
    
    // reduce anxiety
    func reduceAnxiety(to num: CGFloat) {
        canReduceAnxiety = false
        
        let futureWidth = anxietyLevel - num
        
        if futureWidth < 0 {
            anxietyLevel = 0
        } else {
            anxietyLevel = futureWidth
        }
        anxietyBar!.run(SKAction.resize(toWidth: anxietyLevel, duration: 0.2)) {
            self.canReduceAnxiety = true
        }
 
    }
    
    // Get random point outside of the game world ends
    func getRandomPointOutsideGameWorld() -> CGPoint {
        let maxX = Int((tileMapWidth! / 2) + 100)
        let maxY = Int((tileMapHeight! / 2) + 100)
        
        let posXTop = Int.random(in: maxX...maxX + 500)
        let negativeXBottom = Int.random(in: (-maxX - 500)...(-maxX))
        let posYTop = Int.random(in: maxY...maxY + 500)
        let negativeYBottom = Int.random(in: -maxY - 500...(-maxY))
        
        let r = Int.random(in: 0...1)
        let point: CGPoint?
        if r == 0 {
            point = CGPoint(x: posXTop, y: posYTop)
        } else {
            point = CGPoint(x: negativeXBottom, y: negativeYBottom)
        }
        
        return point!
    }
    
    func adjustSizeOfTargetSquare(to height: CGFloat) {
        self.targetSquare?.run(SKAction.resize(toHeight: height, duration: 0.2))
    }
    
    func getHeightOfAllNodesInTargetSquare() -> CGFloat {
        var height: CGFloat = 0
        for node in self.targetSquare!.children {
            height += node.frame.height
        }
        return height + 6
    }

}

