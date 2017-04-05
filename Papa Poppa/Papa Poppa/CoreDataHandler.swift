//
//  CoreDataHandler.swift
//  Papa Poppa
//
//  Created by Charles DiGiovanna on 4/4/17.
//  Copyright © 2017 Charles DiGiovanna. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHandler {
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YaGotFoodDude")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    public static func getLevel(_ callback: ((_ level: Level, _ error: NSError?) -> Void)) {
        let request = NSFetchRequest<Level>(entityName: "Level")

        do {
            let levels = try persistentContainer.viewContext.fetch(request)
            if levels.count > 1 {
                print("Error: > 1 level saved")
                callback(Level(1), nil)
            } else if levels.count == 1 {
                callback(levels[0], nil)
            } else {
                callback(Level(1), nil)
            }
        } catch let error as NSError {
            callback(Level(1), error)
        }
    }
}
