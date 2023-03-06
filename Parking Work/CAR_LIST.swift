//
//  CarLockList.swift
//  Parking Work
//
//  Created by Николай Ногин on 31.01.2023.
//

enum CarNameList: String {
    case OldCopper = "Old Copper"
    case Chowerler = "Chowerler"
}

enum CAR_LOCK_COMPLEXITY_LIST {
    enum oldCopper {
        static var driverLock: Float = 0.10
        static var passengerLock: Float = 0.08
    }
    enum chowerler {
        static var driverLock: Float = 0.90
        static var passengerLock: Float = 0.87
    }
}

