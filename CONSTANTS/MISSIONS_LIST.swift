//
//  MISSIONS_LIST.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.06.2023.
//

enum MISSIONS {
    
    // MISSION -> 1 DATA
    enum Mission1 {
        static let number = 1
        enum EntryScreen {
            static let mainHeader = "Привет, Босс"
            static let shortDescrtiption = "Парковка №17, р-н Чиперово, г. Сероветск."
            static let reputationForEnter: Int = 0
        }
        enum Awards {
            static let money: Float = 4.0
            static let reputation: Int = 2
        }
    }
    
    // MISSION -> 2 DATA
    enum Mission2 {
        static let number = 2
        enum EntryScreen {
            static let mainHeader = "В разработке"
            static let shortDescrtiption = "Миссия 2 всё ещё в разработке..."
            static let reputationForEnter: Int = 6
        }
        enum Awards {
            static let money: Float = 6.1
            static let reputation: Int = 3
        }
    }
    
    // MISSION -> 3 DATA
    enum Mission3 {
        static let number = 3
        enum EntryScreen {
            static let mainHeader = "В разработке"
            static let shortDescrtiption = "Миссия 3 всё ещё в разработке..."
            static let reputationForEnter: Int = 8
        }
        enum Awards {
            static let money: Float = 9.7
            static let reputation: Int = 4
        }
    }
    
    // MISSION -> 4 DATA
    enum Mission4 {
        static let number = 4
        enum EntryScreen {
            static let mainHeader = "В разработке"
            static let shortDescrtiption = "Миссия 4 всё ещё в разработке..."
            static let reputationForEnter: Int = 11
        }
        enum Awards {
            static let money: Float = 12.5
            static let reputation: Int = 3
        }
    }
    
    // MISSION -> 5 DATA
    enum Mission5 {
        static let number = 5
        enum EntryScreen {
            static let mainHeader = "В разработке"
            static let shortDescrtiption = "Миссия 5 всё ещё в разработке..."
            static let reputationForEnter: Int = 15
        }
        enum Awards {
            static let money: Float = 14.1
            static let reputation: Int = 5
        }
    }
    
}
