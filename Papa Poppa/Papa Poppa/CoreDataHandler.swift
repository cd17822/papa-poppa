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
    
    private static func fetchLevels(_ callback: ((_ levels: [Level], _ error: NSError?) -> Void)) {
        let request = NSFetchRequest<Level>(entityName: "Level")
        do {
            let levels = try persistentContainer.viewContext.fetch(request)
            callback(levels, nil)
        } catch let error as NSError {
            callback([], error)
        }
    }
    
    public static func getCurrentLevel(_ callback: @escaping ((_ level: Level, _ error: NSError?) -> Void)) {
        fetchLevels { levels, error in
            if error != nil {
                callback(Level(1), error)
            }else{
                var current_level = Level(1)
                
                for level in levels {
                    if level.isCurrent {
                        current_level = level
                        break
                    }
                }
                
                callback(current_level, nil)
            }
        }
    }
    
    private static func makeCurrentLevel(_ number: Int16, _ callback: ((_ error: NSError?) -> Void)) {
        fetchLevels { levels, error in
            if error != nil {
                callback(error)
            } else {
                for level in levels {
                    if level.number == number {
                        let level_to_save = Level(context: persistentContainer.viewContext)
                        level_to_save.number = level.number
                        level_to_save.best = level.best
                        level_to_save.isCurrent = true
                        
                        do {
                            try persistentContainer.viewContext.save()
                            callback(nil)
                        } catch let error as NSError {
                            callback(error)
                        }
                    }
                }
                callback(nil)
            }
        }
    }
    
    public static func save(level: Level, _ callback: @escaping ((_ error: NSError?) -> Void)) {
        let level_to_save = Level(context: persistentContainer.viewContext)
        level_to_save.number = level.number
        level_to_save.best = level.best
        level_to_save.isCurrent = false
        
        makeCurrentLevel(level.number + 1) { error in
            if error != nil {
                callback(error)
            } else {
                do {
                    try self.persistentContainer.viewContext.save()
                    callback(nil)
                } catch let error as NSError {
                    callback(error)
                }
            }
        }
    }
}
