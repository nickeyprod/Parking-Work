//
//  StorageFunctions.swift
//  Parking Work
//
//  Created by Николай Ногин on 28.06.2023.
//

import SpriteKit
import CoreData

// Game Storage Functions
extension ParkingWorkGame {
    
    func loadGameProgress() {
        
        print("Trying to load Game Progress...")
        
        if player == nil {
            player = Player(scene: self, name: "Фёдор")
        }
        
        storage.persistentContainer.loadPersistentStores { stores, error in
            if let error = error {
                print("Error loading Persistent Stores:")
                print("\(error)")
            } else {
                self.loadPlayerData()
                self.loadProcessedMissions()
                self.loadPlayerInventory()
                // show pop up message
                self.runUpperPopUpAnimation(with: "Данные игры успешно загружены")
            }

        }
    }
    
    func saveGameProgress() {
        print("Trying to save Game Progress...")
        
        guard player != nil else {
            print("No Player to save!")
            return
        }
        storage.persistentContainer.loadPersistentStores { stores, error in
            if let error = error {
                print("Error loading Persistent Stores:")
                print("\(error)")
            } else {
                self.savePlayerData()
                self.saveProcessedMissions()
                self.savePlayerInventory()
                do {
                    // save all changes
                    try self.storage.persistentContainer.viewContext.save()
                    // show pop up message
                    self.runUpperPopUpAnimation(with: "Данные игры успешно cохранены")
                    print("CONTEXT SAVED")

                } catch {
                    print("ERROR SAVING", error)
                }
                
            }
        }
    }
    
    func saveProcessedMissions() {
        do {
            try self.storage.processedMission.performFetch()
            let loadedData = self.storage.processedMission.fetchedObjects
            var foundedMission: ProcessedMissionData? = nil
            
            for mission in player!.processedMissions {

                for loadedMission in loadedData! {
                    if mission?.number == loadedMission.number {
                        foundedMission = loadedMission
                    }
                }
                
                // if found mission, update it
                if foundedMission != nil {
                    foundedMission?.completed = mission!.completed
                    foundedMission?.opened = mission!.opened
                } else {
                    // if not found, add loaded mission
                    let entity = NSEntityDescription.entity(forEntityName: "ProcessedMissionData", in: self.storage.persistentContainer.viewContext)!
                    let newMissionData = ProcessedMissionData(entity: entity, insertInto: self.storage.persistentContainer.viewContext)
                    newMissionData.number = mission!.number
                    newMissionData.opened = mission!.opened
                    newMissionData.completed = mission!.completed
                    self.storage.persistentContainer.viewContext.insert(newMissionData)
                }
            }
        } catch {
            print("Error saving PlayerData")
            print(error)
        }
    }

    func savePlayerData() {
        do {
            try self.storage.playerData.performFetch()
            if let playerData = self.storage.playerData.fetchedObjects {
                
                if playerData.isEmpty {
                    // create
                    let entity = NSEntityDescription.entity(forEntityName: "PlayerData", in: self.storage.persistentContainer.viewContext)!
                    
                    let player = PlayerData(entity: entity, insertInto: self.storage.persistentContainer.viewContext)
                    player.money = self.player!.money
                    player.reputation = self.player!.reputation
                    player.unlockSkill = self.player!.unlockSkill
                    player.inventoryMaxCapacity = self.player!.inventoryMaxCapacity
                    self.storage.persistentContainer.viewContext.insert(player)
                } else {
                    let playerDataEntity = playerData[0]
                    // Set usual entities
                    playerDataEntity.money = self.player!.money
                    playerDataEntity.reputation = self.player!.reputation
                    playerDataEntity.unlockSkill = self.player!.unlockSkill
                    playerDataEntity.inventoryMaxCapacity = self.player!.inventoryMaxCapacity
                }
            }
        } catch {
            print("Error saving PlayerData")
            print(error)
        }
    }
    
    func savePlayerInventory() {
        print("=============================")
        print("Trying to save Player Inventory")
        print("Now in player inventory \(player!.inventory.count) items")

        // remove all from inventory database items
        clearPlayerDatabaseInventory {
            print("Num of items in inventory now: ", player!.inventory.count)
            // add all item
            for item in player!.inventory {
                let entity = NSEntityDescription.entity(forEntityName: "InventoryItem", in: self.storage.persistentContainer.viewContext)!
                
                let newItem = InventoryItem(entity: entity, insertInto: self.storage.persistentContainer.viewContext)
                newItem.id = item!.id
                newItem.name = item!.name
                newItem.type = item!.type
                newItem.assetName = item!.assetName
                newItem.itemDescription = item!.description
                
                self.storage.persistentContainer.viewContext.insert(newItem)
                
                print("saving item: ", item!.name)
                print("it has \(item!.properties.count) props")
                saveProperties(for: newItem, props: item!.properties) {
                    print("properties saved")
                }
            }
        }
    }
    
    // saving properties for item
    func saveProperties(for item: InventoryItem, props: [Property?], done:
                        () -> Void) {
        print("need to save \(props.count) properties")
        do {
            try self.storage.itemProperties.performFetch()
            let allProps = self.storage.itemProperties.fetchedObjects
            print("Now properties count in databse: ", allProps?.count as Any)
            
            ml: for prop in props {
                for loadedProp in allProps! {
                    if prop?.type == loadedProp.type {
                        item.addToPropRel(loadedProp)
                        continue ml
                    }
                }
                
                // if not found, add property
                let entity = NSEntityDescription.entity(forEntityName: "ItemProperty", in: self.storage.persistentContainer.viewContext)!
                let newProperty = ItemProperty(entity: entity, insertInto: self.storage.persistentContainer.viewContext)
                newProperty.inPercentages = ((prop?.inPercentages) != nil)
                newProperty.positive = ((prop?.positive) != nil)
                newProperty.propDescription = prop?.description
                newProperty.type = prop?.type
                newProperty.value = prop!.value
                self.storage.persistentContainer.viewContext.insert(newProperty)
                
                item.addToPropRel(newProperty)
                
                print("Inserted property: ", newProperty)
            }
            done()
        } catch {
            print("Error saving propertied: ")
            print(error)
        }
    }
    
    func loadPlayerInventory() {
        do {
            try self.storage.playerInventory.performFetch()
            let loadedItems = self.storage.playerInventory.fetchedObjects
            if loadedItems!.isEmpty {
                print("Fetched PlayerInventory array is empty")
                return
            }
            // just update mission if already exists
            self.player?.inventory.removeAll()
            
            // add loaded items
            for loadedItem in loadedItems! {
            
                let allProps = getItemProperties(for: loadedItem.propRel!.allObjects)
                
                let loadedItem = GameItem(
                    id: loadedItem.id,
                    name: loadedItem.name!,
                    type: loadedItem.type!,
                    assetName: loadedItem.assetName!,
                    description: loadedItem.itemDescription!,
                    properties: allProps
                )
                
                
                // if not found add it
                self.player!.inventory.append(loadedItem)
            }
        } catch {
            print("Error loading ProcessedMissions:")
            print(error)
        }
    }
    
    func getItemProperties(for items: [Any?]) -> [Property?] {

        if items.isEmpty {
            print("Fetched ItemProperties array is empty")
            return []
        }
        
        var itemProperties: [Property]  = []
        
        // add loaded props
        for item in items {
            if let item = item as? ItemProperty {
                let itemProperty = Property(
                    type: item.type!,
                    positive: item.positive,
                    description: item.propDescription!,
                    value: item.value,
                    inPercentages: item.inPercentages
                )
                
                itemProperties.append(itemProperty)
            }
           
        }
        return itemProperties
       
    }
    
    func loadProcessedMissions() {
        do {
            try self.storage.processedMission.performFetch()
            let loadedData = self.storage.processedMission.fetchedObjects
            
            if loadedData!.isEmpty {
                print("Fetched ProcessedMissions array is empty")
                return
            }
            // add loaded missions
            for loadedMission in loadedData! {
        
                let loadedProcessedMission = ProcessedMission(
                    number: loadedMission.number,
                    opened: loadedMission.opened,
                    completed: loadedMission.completed
                )
                // just update mission if already exists
                for processedMissionNum in 0...self.player!.processedMissions.count - 1 {
                    if loadedProcessedMission.number == self.player!.processedMissions[processedMissionNum]?.number {
                        self.player!.processedMissions[processedMissionNum]?.opened = loadedMission.opened
                        self.player!.processedMissions[processedMissionNum]?.completed = loadedMission.completed
                    }
                }

                // if not found add it
                self.player!.processedMissions.append(loadedProcessedMission)
            }
        } catch {
            print("Error loading ProcessedMissions:")
            print(error)
        }
    }
    
    func loadPlayerData() {
        do {
            try self.storage.playerData.performFetch()
            if let playerData = self.storage.playerData.fetchedObjects {
                if playerData.count > 0 {
                    let data = playerData[0]
                    self.player?.unlockSkill = data.unlockSkill
                    self.player?.reputation = data.reputation
                    self.player?.money = data.money
                    self.player?.inventoryMaxCapacity = data.inventoryMaxCapacity
                } else {
                    print("PlayerData is empty")
                }
            }
        } catch {
            print("Error loading PlayerData: ")
            print(error)
        }
    }
    
    func clearGameDatabase() {
        storage.persistentContainer.loadPersistentStores { stores, error in
            if let error = error {
                print("Error loading Persistent Stores:")
                print("\(error)")
            } else {
                self.clearProcessedMissions()
                self.clearPlayerData()
                self.clearPlayerDatabaseInventory {
                    print("clear database ok")
                }
            }
        }
    }
    
    func clearPlayerData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PlayerData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try storage.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: storage.persistentContainer.viewContext)
        } catch let error as NSError {
            // TODO: handle the error
            print("Error clearing PlayerData: ")
            print(error)
        }
    }
    
    func clearProcessedMissions() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ProcessedMissionData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try storage.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: storage.persistentContainer.viewContext)
        } catch let error as NSError {
            // TODO: handle the error
            print("Error clearing processed missions: ")
            print(error)
        }
    }
    
    func clearPlayerDatabaseInventory(done: () -> ()) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "InventoryItem")
        let fetchReq2: NSFetchRequest<NSFetchRequestResult> =
        NSFetchRequest(entityName: "ItemProperty")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let deleteReq2 = NSBatchDeleteRequest(fetchRequest: fetchReq2)
        do {
            try storage.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: storage.persistentContainer.viewContext)
            try storage.persistentContainer.persistentStoreCoordinator.execute(deleteReq2, with: storage.persistentContainer.viewContext)
            done()
        } catch let error as NSError {
            print("Error clearing InventoryItems: ")
            print(error)
        }
    }

}
