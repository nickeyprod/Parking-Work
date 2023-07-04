//
//  ItemProperty+CoreDataProperties.swift
//  Parking Work
//
//  Created by Николай Ногин on 04.07.2023.
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
    @NSManaged public var inventoryRel: NSSet?

}

// MARK: Generated accessors for inventoryRel
extension ItemProperty {

    @objc(addInventoryRelObject:)
    @NSManaged public func addToInventoryRel(_ value: InventoryItem)

    @objc(removeInventoryRelObject:)
    @NSManaged public func removeFromInventoryRel(_ value: InventoryItem)

    @objc(addInventoryRel:)
    @NSManaged public func addToInventoryRel(_ values: NSSet)

    @objc(removeInventoryRel:)
    @NSManaged public func removeFromInventoryRel(_ values: NSSet)

}

extension ItemProperty : Identifiable {

}
