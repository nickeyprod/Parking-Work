//
//  InventoryItem+CoreDataProperties.swift
//  Parking Work
//
//  Created by Николай Ногин on 04.07.2023.
//
//

import Foundation
import CoreData


extension InventoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InventoryItem> {
        return NSFetchRequest<InventoryItem>(entityName: "InventoryItem")
    }

    @NSManaged public var assetName: String?
    @NSManaged public var id: Int
    @NSManaged public var itemDescription: String?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Int
    @NSManaged public var type: String?
    @NSManaged public var propRel: NSSet?

}

// MARK: Generated accessors for propRel
extension InventoryItem {

    @objc(addPropRelObject:)
    @NSManaged public func addToPropRel(_ value: ItemProperty)

    @objc(removePropRelObject:)
    @NSManaged public func removeFromPropRel(_ value: ItemProperty)

    @objc(addPropRel:)
    @NSManaged public func addToPropRel(_ values: NSSet)

    @objc(removePropRel:)
    @NSManaged public func removeFromPropRel(_ values: NSSet)

}

extension InventoryItem : Identifiable {

}
