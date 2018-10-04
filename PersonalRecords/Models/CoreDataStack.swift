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
    guard let modelURL = Bundle.main.url(forResource: "Record", withExtension: "momd") else {
        fatalError("Cannot get record model url")
    }
    
    let storeURL = URL.mainDocumentsPath.appendingPathComponent(session.user.userId.uuidString + "_Record.sqlite")
    return createContext(modelURL: modelURL, storeURL: storeURL, inMemory: inMemory)
    //Initialize and return
}

func createUserContext(inMemory: Bool = false) -> NSManagedObjectContext {
    guard let modelURL = Bundle.main.url(forResource: "User", withExtension: "momd") else {
        fatalError("Cannot get user model url")
    }
    let storeURL = URL.mainDocumentsPath.appendingPathComponent("LocalUsers.sqlite")

    return createContext(modelURL: modelURL, storeURL: storeURL, inMemory: inMemory)
}

private func createContext(modelURL: URL, storeURL: URL, inMemory: Bool) -> NSManagedObjectContext {
    guard let model = NSManagedObjectModel(contentsOf: modelURL) else {fatalError("model cannot be created")}
    
    //Configure NSPersistentStoreCoordinator
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    //Add NSPersistenStore to coordinator
    
    
    //try! FileManager.default.removeItem(at: storeURL)
    if(!inMemory) {
        let pscOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                          NSInferMappingModelAutomaticallyOption: false]

        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: pscOptions)

        } catch {
            print(error)
            fatalError("Cannot create persistent store")
        }
    }
    else {
        do {
            try psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
    }
    
    
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    return context
}

extension URL {
    static var mainDocumentsPath : URL {
    return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}

protocol NSManagedObjectContextDependent {
    var context : NSManagedObjectContext! {get set}
}
