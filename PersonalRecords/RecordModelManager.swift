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
        
        record.sport = Sport.Unknown.getValue()
        record.id = UUID()
        record.type = type.getValue()
        record.title = ""
        record.time = 0
        record.distance = 0
        record.weight = 0
        record.reps = 0
        record.isTemplate = isTemplate
        
        return record
    }
    
    func createRecordWith(type: RecordType, isTemplate: Bool) -> Recordable? {

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
    
    func copyRecord(record copied: Recordable) -> Recordable?
    {
        do {
            let record = initRecord(type: RecordType(value: copied.type), isTemplate: copied.isTemplate)
            record.distance = copied.distance
            record.recordDescription = copied.recordDescription
            record.title = copied.title
            record.reps = copied.reps
            record.sport = copied.sport
            record.time = copied.time
            record.weight = copied.weight
            
            try context.save()
            
            return record
        } catch {
            context.rollback()
            print (error)
            print("Could not save new record")
            return nil
        }
    }
    
    func getRecordBy( id: UUID) -> Recordable? {
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
    
    func deleteRecordBy( id: UUID) -> Bool {
        if let record = getRecordBy(id: id) as? RecordModel {
            context.delete(record)
            return true
        }
        return false
    }
    
    func getRecordsWith( predicate: NSPredicate) -> [Recordable] {
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


