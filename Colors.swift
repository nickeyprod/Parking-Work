//
//  Colors.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.02.2023.
//

import SpriteKit

enum Colors: String {
    // Open Car Suggest Window
    case OpenCarWindowColor
    case OpenCarWindowColorStroke
    case OpenCarWindowCarNameColor
    case OpenCarWindowCarMsgColor
    case OpenCarWindowLockTypeColor
    case OpenCarWindowComplexityColor
    case OpenCarYesBtnColor
    
    // Open Car Success Window
    case OpenCarSuccessWindowColor
    case OpenCarSuccessWindowSuccessLabelColor
    case OpenCarSuccessWindowGarageLabelColor
    
    // lock complexities
    case OpenCarLockComplexityLightColor
    case OpenCarLockComplexityMiddleColor
    case OpenCarLockComplexityHardColor
    
    // task screen
    case TaskMessageBackground
    
    // level list 
    case ReputationNeededGreen
    case PlayButtonNormal
    
    // menu colors
    static var MenuButtonsColor = SKColor(red: 1.0, green: 0.723, blue: 0.315, alpha: 1.0)
    static var GameNameLabelColor = SKColor(red: 1.0, green: 0.684, blue: 0.213, alpha: 1.0)
    static var Danger70Anxiety = UIColor(named: "Danger70Anxiety")
    static var DangerNormalAnxiety = UIColor(named: "DangerNormalAnxiety")
    static var DangerStrokeRed = SKColor(red: 1.0, green: 0.098, blue: 0.126, alpha: 1.0)
    static var SplashScreenBackgroundColor = UIColor(named: "SplashScreenColor")
    
}
