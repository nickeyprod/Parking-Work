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
        oldCopper!.miniMapDot = SKShapeNode(rectOf: CGSize(width: 6, height: 6))
        oldCopper!.miniMapDot?.fillColor = .green
        
        var miniMapX = (oldCopper!.node?.position.x)! / scaleWidthFactor * miniMapScaleFactor
        var minimapY = (oldCopper!.node?.position.y)! / scaleHeightFactor * miniMapScaleFactor

        oldCopper!.miniMapDot?.position = CGPoint(x: miniMapX, y: minimapY)

        miniMapCropNode?.addChild(oldCopper!.miniMapDot!)
        
        // chowerler
        chowerler!.miniMapDot = SKShapeNode(rectOf: CGSize(width: 6, height: 6))
        chowerler!.miniMapDot?.fillColor = .green
        
        miniMapX = (chowerler!.node?.position.x)! / scaleWidthFactor * miniMapScaleFactor
        minimapY = (chowerler!.node?.position.y)! / scaleHeightFactor * miniMapScaleFactor

        chowerler!.miniMapDot?.position = CGPoint(x: miniMapX, y: minimapY)

        miniMapCropNode?.addChild(chowerler!.miniMapDot!)
    }
    
}
