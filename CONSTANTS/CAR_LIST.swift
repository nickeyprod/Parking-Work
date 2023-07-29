//
//  CarLockList.swift
//  Parking Work
//
//  Created by Николай Ногин on 31.01.2023.
//

import SpriteKit

enum CAR_LIST: String {
    case OldCopper = "Old Copper"
    case Chowerler = "Chowerler"
    case Posblanc = "Posblanc"
    case Policia = "Policia"
}

enum OldCopper {
    static let mass: CGFloat = 896
    static let anchorPoint = CGPoint(x: 0.49, y: 0.5)
    static let initialSpeed: CGFloat = 10
    static let maxSpeedForward: CGFloat = 150
    static let maxSpeedBackward: CGFloat = 60
    static let turningSpeed: CGFloat = 0.006
    static let accelerationRate: CGFloat = 1
    static let secondaryAcceleration: CGFloat = 0.01
    static let brakeRate: CGFloat = 1.5
    static let smokeRate: CGFloat = 10
}

enum Chowerler {
    static let mass: CGFloat = 1061
    static let anchorPoint = CGPoint(x: 0.49, y: 0.495)
    static let initialSpeed: CGFloat = 10
    static let maxSpeedForward: CGFloat = 200
    static let maxSpeedBackward: CGFloat = 75
    static let turningSpeed: CGFloat = 0.012
    static let accelerationRate: CGFloat = 1
    static let secondaryAcceleration: CGFloat = 0.01
    static let brakeRate: CGFloat = 2
    static let smokeRate: CGFloat = 10
}

enum Posblanc {
    static let mass: CGFloat = 1102
    static let anchorPoint = CGPoint(x: 0.49, y: 0.495)
    static let initialSpeed: CGFloat = 12
    static let maxSpeedForward: CGFloat = 240
    static let maxSpeedBackward: CGFloat = 84
    static let turningSpeed: CGFloat = 0.016
    static let accelerationRate: CGFloat = 1.2
    static let secondaryAcceleration: CGFloat = 0.012
    static let brakeRate: CGFloat = 2.2
    static let smokeRate: CGFloat = 8
}

enum Policia {
    static let mass: CGFloat = 996
    static let anchorPoint = CGPoint(x: 0.49, y: 0.5)
    static let initialSpeed: CGFloat = 15
    static let maxSpeedForward: CGFloat = 246
    static let maxSpeedBackward: CGFloat = 86
    static let turningSpeed: CGFloat = 0.018
    static let accelerationRate: CGFloat = 1.22
    static let secondaryAcceleration: CGFloat = 0.0122
    static let brakeRate: CGFloat = 2.4
    static let smokeRate: CGFloat = 11
}
