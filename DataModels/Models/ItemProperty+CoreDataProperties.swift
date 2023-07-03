//
//  ItemProperty+CoreDataProperties.swift
//  Parking Work
//
//  Created by Николай Ногин on 02.07.2023.
//
//

import Foundation
import CoreData


extension ItemProperty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemProperty> {
        return NSFetchRequest<ItemProperty>(entityName: "ItemProperty")
    }

    @NSManaged public var inPercentages: Bool
    @NSManaged public var positive: Bool
    @NSManaged public var propDescription: String?
    @NSManaged public var type: String?
    @NSManaged public var value: Float
    @NSManaged public var inventoryRel: InventoryItem?

}

extension ItemProperty : Identifiable {

}
