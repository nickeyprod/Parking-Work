//
//  MiniMapSetup.swift
//  Parking Work
//
//  Created by Николай Ногин on 12.03.2023.
//


import SpriteKit

// Mission 1 World Bounds Setup
extension Mission1 {
    
    func setupCarsOnMap() {
        // add cars dots to mini map
        
        let scaleWidthFactor = tileMapWidth! / miniMapWidth!
        let scaleHeightFactor = tileMapHeight! / miniMapHeight!
        
        for car in carsOnLevel {
            car?.miniMapDot = SKShapeNode(rectOf: CGSize(width: 4, height: 4))
            car?.miniMapDot?.fillColor = .green
            
            var miniMapX = (car?.node?.position.x)! / scaleWidthFactor
            var minimapY = (car?.node?.position.y)! / scaleHeightFactor

            car?.miniMapDot?.position = CGPoint(x: miniMapX, y: minimapY)

            miniMapSprite?.addChild((car?.miniMapDot)!)
        }
    }
    
}
