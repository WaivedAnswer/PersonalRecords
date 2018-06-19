//
//  RecordManager.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-06-14.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

class RecordModelManager : NSManagedObjectContextDependent {
    var context: NSManagedObjectContext!

    init(mainContext: NSManagedObjectContext) {
        context = mainContext
    }
    
    private func initRecord(type: RecordType, isTemplate: Bool) -> RecordModel
    {
        let record = NSEntityDescription.insertNewObject(
            forEntityName: RecordModel.entityName,
            into: context) as! RecordModel
        
        record.id = UUID()
        record.type = type
        record.title = ""
        record.time = 0
        record.distance = 0
        record.weight = 0
        record.reps = 0
        record.isTemplate = isTemplate
        
        return record
    }
    
    func createRecordTypeWith(name: String, displayUnit: String) -> RecordType?
    {
        do {
            let type = NSEntityDescription.insertNewObject(
                forEntityName: RecordType.entityName,
                into: context) as! RecordType

            type.id = UUID()
            type.name = name
            type.displayUnit = displayUnit
            
            try context.save()
            
            return type
        } catch {
            context.rollback()
            print (error)
            print("Could not save new record type")
            return nil
        }
    }
    
    func createRecordWith(type: RecordType, isTemplate: Bool) -> RecordModel? {

        do {
            let record = initRecord(type: type, isTemplate: isTemplate)
            
            try context.save()
            
            return record
        } catch {
            context.rollback()
            print (error)
            print("Could not save new record")
            return nil
        }
    }
    
    func getRecordBy( id: UUID) -> RecordModel? {
        do {
            let request = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
            request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
            let results = try context.fetch(request)
            return results.first
        } catch {
            print(error)
            print("Could not get record")
            return nil
        }
    }
    
    func getRecordsWith( predicate: NSPredicate) -> [RecordModel] {
        do {
            let request = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
            request.predicate = predicate
            let results = try context.fetch(request)
            return results
        } catch {
            print(error)
            print("Could not get records")
            return []
        }
    }
    
}


