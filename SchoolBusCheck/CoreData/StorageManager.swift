//
//  DataController.swift
//  SchoolBusCheck
//
//  Created by trink2 on 5/22/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import UIKit
import CoreData

class StorageManager {
    
    let persistentContainer: NSPersistentContainer!
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    let schoolBusEntityName = "SchoolBus"
    
    init(container: NSPersistentContainer) {
        persistentContainer = container
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        let container = NSPersistentContainer(name: "SchoolBusCheck")
        container.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        
        self.init(container: container)
    }
    
    func saveAllBuses(_ buses: [SchoolBus]) {
        for bus in buses {
            saveSchoolBus(bus)
        }
    }
    
    func saveSchoolBus(_ bus: SchoolBus) {
        guard let schoolBusMO = NSEntityDescription.insertNewObject(forEntityName: schoolBusEntityName, into: backgroundContext) as? SchoolBusMO else  { return }
        schoolBusMO.id = Int32(bus.id)
        schoolBusMO.name = bus.name
        schoolBusMO.busDescription = bus.description
        schoolBusMO.imageData = bus.imageData
        schoolBusMO.imageUrl = bus.imageUrl
        schoolBusMO.routeUrl = bus.routeUrl
        schoolBusMO.route = bus.route
        
        var coordinates: [Coordinate] = []
        for location in bus.coordinatesList {
            if let coordinate = NSEntityDescription.insertNewObject(forEntityName: "Coordinate", into: backgroundContext) as? Coordinate {
                coordinate.lat = location.lat
                coordinate.lng = location.lng
                coordinates.append(coordinate)
            }
        }
        
        schoolBusMO.coordinates = NSOrderedSet(array: coordinates)
        
        do {
            try backgroundContext.save()
        } catch {
            print("Failed to store into DB: \(error)")
        }
        
    }
    
    func fetchAllBuses() -> [SchoolBus] {
        let schoolBusFetch = NSFetchRequest<NSFetchRequestResult>(entityName: schoolBusEntityName)
        do {
            let fetch = try persistentContainer.viewContext.fetch(schoolBusFetch) as! [SchoolBusMO]
            var busList: [SchoolBus] = []
            for bus in fetch {
                let schoolBus = SchoolBus()
                schoolBus.id = Int(bus.id)
                schoolBus.name = bus.name!
                schoolBus.description = bus.busDescription!
                schoolBus.imageUrl = bus.imageUrl!
                schoolBus.imageData = bus.imageData!
                schoolBus.routeUrl = bus.routeUrl!
                schoolBus.route = bus.route!
                schoolBus.coordinates = bus.coordinates?.array as! [Coordinate]
                busList.append(schoolBus)
            }
            return busList
        } catch {
            return []
        }
    }
    
}
