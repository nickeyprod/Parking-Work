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
        static var driverLock: Float = 10.00
        static var passengerLock: Float = 8.0
    }
    enum chowerler {
        static var driverLock: Float = 90.0
        static var passengerLock: Float = 90.0
    }
}

