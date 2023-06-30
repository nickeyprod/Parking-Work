//
//  ITEMS_TYPES.swift
//  Parking Work
//
//  Created by Николай Ногин on 07.06.2023.
//

import Foundation

enum ITEMS_TYPES: Equatable {
    
    // List of all possible picklocks in the game
    enum PICKLOCKS {
        static let TYPE = "picklock"
        
        // usual picklock
        enum usual_picklock {
            static let id = 1
            static let name = "Обыкновенная отмычка"
            static let gamePrice = 12
            static let assetName = "usual_picklock"
            static let properties: [Property] = []
            static let description = "Даёт возможность вскрывать замки."
        }
        
        // better picklock
        enum better_picklock {
            static let id = 2
            static let name = "Улучшенная отмычка"
            static let gamePrice = 109
            static let assetName = "better_picklock"
            static let properties = [
                Property(type: "chanceOfOpen", positive: true, description: "[+10%] к шансу вскрытия", value: 10, inPercentages: true)
                
            ]
            static let description = "Справляется лучше, чем обыкновенная отмычка."
        }
        
        // professional picklock
        enum professional_picklock {
            static let id = 3
            static let name = "Профессиональная отмычка"
            static let rubPrice = 15
            static let assetName = "professional_picklock"
            static let properties = [
                Property(type: "chanceOfOpen", positive: true, description: "[+90%] к шансу вскрытия", value: 90, inPercentages: true),
                Property(type: "chanceOfJamming", positive: true, description: "[-50%] шанс клина замка", value: -50, inPercentages: true)
            ]
            static let description = "Шанс провала с ней всего 10% - вам не о чем беспокоиться."
        }
    }
}
