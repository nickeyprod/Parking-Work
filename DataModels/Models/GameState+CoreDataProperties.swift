//
//  GameState+CoreDataProperties.swift
//  Parking Work
//
//  Created by Николай Ногин on 20.07.2023.
//
//

import Foundation
import CoreData


extension GameState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameState> {
        return NSFetchRequest<GameState>(entityName: "GameState")
    }

    @NSManaged public var tutorialEnded: Bool

}

extension GameState : Identifiable {

}
