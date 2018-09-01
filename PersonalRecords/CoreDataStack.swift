//
//  CoreDataStack.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-03.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

func createMainContext (session: Session, inMemory: Bool = false) -> NSManagedObjectContext {
    //initialize NSManagedObjecTModel
    let modelURL = Bundle.main.url(forResource: "Record", withExtension: "momd")
    guard let model = NSManagedObjectModel(contentsOf: modelURL!) else {fatalError("model cannot be created")}
    
    //Configure NSPersistentStoreCoordinator
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    //Add NSPersistenStore to coordinator
    let storeURL = URL.mainDocumentsPath.appendingPathComponent(session.userId + "_Record.sqlite")
    
    //try! FileManager.default.removeItem(at: storeURL)
    if(!inMemory) {
        let pscOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                          NSInferMappingModelAutomaticallyOption: true]
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: pscOptions)
        } catch {
            fatalError("Cannot create persistent store")
        }
    } else {
        do {
            try psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
    }
    
    
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    return context
    //Initialize and return
}

extension URL {
    static var mainDocumentsPath : URL {
    return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}

protocol NSManagedObjectContextDependent {
    var context : NSManagedObjectContext! {get set}
}
