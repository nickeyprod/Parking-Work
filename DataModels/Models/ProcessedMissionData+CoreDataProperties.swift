//
//  ProcessedMissionData+CoreDataProperties.swift
//  Parking Work
//
//  Created by Николай Ногин on 29.06.2023.
//
//

import Foundation
import CoreData


extension ProcessedMissionData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProcessedMissionData> {
        return NSFetchRequest<ProcessedMissionData>(entityName: "ProcessedMissionData")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var number: Int
    @NSManaged public var opened: Bool

}

extension ProcessedMissionData : Identifiable {

}
