//
//  Storage.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.06.2023.
//

import Foundation
import CoreData

class Storage {
    let persistentContainer = NSPersistentContainer(name: "ParkingWorkModel")
    
    lazy var playerData: NSFetchedResultsController<PlayerData> = {
        let fetchRequest = PlayerData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "money", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultsController
    }()
    
    lazy var playerInventory: NSFetchedResultsController<InventoryItem> = {
        let fetchRequest = InventoryItem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultsController
    }()
    
    lazy var processedMission: NSFetchedResultsController<ProcessedMissionData> = {
        let fetchRequest = ProcessedMissionData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultsController
    }()
    
    lazy var itemProperties: NSFetchedResultsController<ItemProperty> = {
        let fetchRequest = ItemProperty.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "type", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultsController
    }()
    
    lazy var gameState: NSFetchedResultsController<GameState> = {
        let fetchRequest = GameState.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "tutorialEnded", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultsController
    }()

}
