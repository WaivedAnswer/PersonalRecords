//
//  DataService.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-08.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

struct DataService: NSManagedObjectContextDependent {
    var context: NSManagedObjectContext!
    
    func AddRecordType(id: UUID, name: String)
    {
        let recordType = NSEntityDescription.insertNewObject(forEntityName: RecordType.entityName, into: context) as! RecordType
        recordType.name = name
        recordType.id = id
    }
    
    func AddSportType(id: UUID, name: String)
    {
        let sportType = NSEntityDescription.insertNewObject(forEntityName: Sport.entityName, into: context) as! Sport
        sportType.name = name
        sportType.id = id
    }
    
    func seedRecordTypes () {
        let recordTypeFetchRequest = NSFetchRequest<RecordType>(entityName: RecordType.entityName)
        do {
            let typesAlreadySeeded = try context.fetch(recordTypeFetchRequest).count > 0
            if(typesAlreadySeeded == false)
            {
                AddRecordType(id: UUID(), name: "Distance")
                AddRecordType(id: UUID(), name: "Weight")
                AddRecordType(id: UUID(), name: "Time")
                AddRecordType(id: UUID(), name: "Repetition")
                do {
                    try context.save()
                } catch {
                    context.rollback()
                    print(error.localizedDescription + " in seeding record types")
                }
            }
        } catch {}
    }
    
    func seedSportTypes () {
        let sportFetchRequest = NSFetchRequest<Sport>(entityName: Sport.entityName)
        do {
            let typesAlreadySeeded = try context.fetch(sportFetchRequest).count > 0
            if(typesAlreadySeeded == false)
            {
                AddSportType(id: UUID(), name: "Running")
                AddSportType(id: UUID(), name: "Swimming")
                AddSportType(id: UUID(), name: "Road Biking")
                AddSportType(id: UUID(), name: "Triathlon")
                AddSportType(id: UUID(), name: "Weightlifting")
                AddSportType(id: UUID(), name: "Crossfit")
                AddSportType(id: UUID(), name: "Track & Field")
                do {
                    try context.save()
                } catch {
                    context.rollback()
                    print(error.localizedDescription + " in seeding sport types")
                }
            }
        } catch {}
    }
    
    func seedStandardRecordTemplates () {
        
    }
}
