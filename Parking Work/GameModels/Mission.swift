//
//  Mission.swift
//  Parking Work
//
//  Created by Николай Ногин on 01.06.2023.
//

import Foundation


struct Mission {
    var number: Int
    var mainHeader: String
    var reputationForEnter: Float
    var shortDescription: String
    
    var numberAsString: String {
        get {
            "Миссия \(number)"
        }
    }
}
