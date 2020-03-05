//
//  CoreDataStack.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-03.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

func createMainContext () -> NSManagedObjectContext {
    
    let modelURL = getRecordModelURL()
    let storeURL = getRecordStoreURL()
    
    return createContext(modelURL: modelURL, storeURL: storeURL)
}

func createRecordContextForTest () -> NSManagedObjectContext {
    let modelURL = getRecordModelURL()
    let storeURL = getRecordStoreURL()
    
    return createContextForTesting(modelURL: modelURL, storeURL: storeURL)
}

private func createContext(modelURL: URL, storeURL: URL) -> NSManagedObjectContext {

    let psc = createPersistentStoreCoordinator(modelURL: modelURL)
    
    configurePersistentStore(psc, storeURL)
    
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    return context
}

private func createContextForTesting(modelURL: URL, storeURL: URL) -> NSManagedObjectContext {

    let psc = createPersistentStoreCoordinator(modelURL: modelURL)
    
    configurePersistentStoreForTesting(psc)
    
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    return context
}

private func createPersistentStoreCoordinator(modelURL: URL) -> NSPersistentStoreCoordinator {
    guard let model = NSManagedObjectModel(contentsOf: modelURL) else {fatalError("model cannot be created")}
    
    return NSPersistentStoreCoordinator(managedObjectModel: model)
}

fileprivate func configurePersistentStore(_ psc: NSPersistentStoreCoordinator, _ storeURL: URL) {
    let pscOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                      NSInferMappingModelAutomaticallyOption: false]
    
    do {
        try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: pscOptions)
        
    } catch {
        print(error)
        fatalError("Cannot create persistent store")
    }
}

fileprivate func configurePersistentStoreForTesting(_ psc: NSPersistentStoreCoordinator) {
    do {
        try psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    } catch {
        print("Adding in-memory persistent store failed")
    }
}

private func getRecordModelURL() -> URL {
    guard let modelURL = Bundle.main.url(forResource: "Record", withExtension: "momd") else {
        fatalError("Cannot get record model url")
    }
    return modelURL
}

private func getRecordStoreURL() -> URL {
    return URL.mainDocumentsPath.appendingPathComponent("Record.sqlite")
}

extension URL {
    static var mainDocumentsPath : URL {
    return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}

protocol NSManagedObjectContextDependent {
    var context : NSManagedObjectContext! {get set}
}
