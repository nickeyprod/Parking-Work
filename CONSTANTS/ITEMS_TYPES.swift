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
            static let name = "Обыкновенная отмычка"
            static let assetName = "usual_picklock"
            static let properties: [String] = []
            static let description = "Даёт возможность вскрывать замки."
        }
        
        // better picklock
        enum better_picklock {
            static let name = "Улучшенная отмычка"
            static let assetName = "better_picklock"
            static let properties = ["+10% шанс вскрытия"]
            static let description = "Справляется лучше, чем обыкновенная отмычка."
        }
        
        // professional picklock
        enum professional_picklock {
            static let name = "Профессиональная отмычка"
            static let assetName = "professionsl_picklock"
            static let properties = ["+90% шанс вскрытия", "-50% шанс клина замка"]
            static let description = "Шанс провала с ней всего 10% - вам не о чем беспокоиться."
        }
    }
}
