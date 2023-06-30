//
//  Mission.swift
//  Parking Work
//
//  Created by Николай Ногин on 01.06.2023.
//

import Foundation


class Mission {
    
    init(number: Int, mainHeader: String, reputationForEnter: Int, shortDescription: String, moneyAward: Float, reputationAward: Int) {
        self.number = number
        self.mainHeader = mainHeader
        self.reputationForEnter = reputationForEnter
        self.shortDescription = shortDescription
        self.moneyAward = moneyAward
        self.reputationAward = reputationAward
    }
    
    var number: Int
    var mainHeader: String
    var reputationForEnter: Int
    var shortDescription: String
    
    var numberAsString: String {
        get {
            "Миссия \(number)"
        }
    }
    
    var moneyAward: Float
    var reputationAward: Int
}
