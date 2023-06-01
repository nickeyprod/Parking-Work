//
//  Level.swift
//  Parking Work
//
//  Created by Николай Ногин on 01.06.2023.
//

import Foundation


struct Level {
    var number: Int
    var mainHeader: String
    var reputationForEnter: Float
    var shortDescription: String
    
    var numberAsString: String {
        get {
            "Уровень \(number)"
        }
    }
}
