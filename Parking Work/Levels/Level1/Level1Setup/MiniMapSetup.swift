//
//  MiniMapSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 12.03.2023.
//


import SpriteKit

// Level 1 World Bounds Setup
extension Level1 {
    
    func setupCarsOnMap() {
        // add cars dots to mini map
        
        let scaleWidthFactor = tileMapWidth! / miniMapWidth!
        let scaleHeightFactor = tileMapHeight! / miniMapHeight!
        
        // Old Copper
        oldCopper!.miniMapDot = SKShapeNode(rectOf: CGSize(width: 4, height: 4))
        oldCopper!.miniMapDot?.fillColor = .green
        
        var miniMapX = (oldCopper!.node?.position.x)! / scaleWidthFactor
        var minimapY = (oldCopper!.node?.position.y)! / scaleHeightFactor

        oldCopper!.miniMapDot?.position = CGPoint(x: miniMapX, y: minimapY)

        miniMapSprite?.addChild(oldCopper!.miniMapDot!)
        
        // chowerler
        chowerler!.miniMapDot = SKShapeNode(rectOf: CGSize(width: 4, height: 4))
        chowerler!.miniMapDot?.fillColor = .green
        
        miniMapX = (chowerler!.node?.position.x)! / scaleWidthFactor
        minimapY = (chowerler!.node?.position.y)! / scaleHeightFactor

        chowerler!.miniMapDot?.position = CGPoint(x: miniMapX, y: minimapY)

        miniMapSprite?.addChild(chowerler!.miniMapDot!)
    }
    
}
