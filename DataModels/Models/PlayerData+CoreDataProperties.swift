//
//  PlayerData+CoreDataProperties.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.06.2023.
//
//

import Foundation
import CoreData


extension PlayerData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerData> {
        return NSFetchRequest<PlayerData>(entityName: "PlayerData")
    }

    @NSManaged public var inventoryMaxCapacity: Int
    @NSManaged public var money: Float
    @NSManaged public var reputation: Int
    @NSManaged public var unlockSkill: Float

}

extension PlayerData : Identifiable {

}
