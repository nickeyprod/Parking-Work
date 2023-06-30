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
        
        self.loadPlayerData()
        self.loadProcessedMissions()
       
    }
    
    func saveGameProgress() {
        print("Trying to save Game Progress...")
        
        guard player != nil else {
            print("No Player to save!")
            return
        }
        self.savePlayerData()
        self.saveProcessedMissions()
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
            // save all changes
            try self.storage.persistentContainer.viewContext.save()

        } catch {
            print("Error saving PlayerData")
            print(error)
        }
    }

    func savePlayerData() {
        do {
            try self.storage.playerData.performFetch()
            let playerData = self.storage.playerData.fetchedObjects![0]
            
            // Set usual entities
            playerData.money = self.player!.money
            playerData.reputation = self.player!.reputation
            playerData.unlockSkill = self.player!.unlockSkill
            playerData.inventoryMaxCapacity = self.player!.inventoryMaxCapacity
            
            // save all changes
            try self.storage.playerData.managedObjectContext.save()
        } catch {
            print("Error saving PlayerData")
            print(error)
        }
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
}
