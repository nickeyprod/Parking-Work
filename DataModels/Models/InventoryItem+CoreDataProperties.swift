//
//  InventoryItem+CoreDataProperties.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.06.2023.
//
//

import Foundation
import CoreData


extension InventoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InventoryItem> {
        return NSFetchRequest<InventoryItem>(entityName: "InventoryItem")
    }

    @NSManaged public var id: Int64

}

extension InventoryItem : Identifiable {

}
