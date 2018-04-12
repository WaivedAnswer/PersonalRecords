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
    
    func AddRecordType(id: UUID, name: String, displayUnit: String)
    {
        let recordType = NSEntityDescription.insertNewObject(forEntityName: RecordType.entityName, into: context) as! RecordType
        recordType.name = name
        recordType.id = id
        recordType.displayUnit = displayUnit
    }
    
    func AddSportType(id: UUID, name: String)
    {
        let sportType = NSEntityDescription.insertNewObject(forEntityName: Sport.entityName, into: context) as! Sport
        sportType.name = name
        sportType.id = id
    }
    
    func AddRecordTemplate(id: UUID, title: String, type: RecordType, sport: Sport)
    {
        let record = NSEntityDescription.insertNewObject(forEntityName: RecordModel.entityName, into: context) as! RecordModel
        record.title = title
        record.id = id
        record.type = type
        record.sport = sport
        record.isTemplate = true
    }
    
    func seedRecordTypes () {
        let recordTypeFetchRequest = NSFetchRequest<RecordType>(entityName: RecordType.entityName)
        do {
            let types = try context.fetch(recordTypeFetchRequest)
            let typesAlreadySeeded = types.count > 0
            if(typesAlreadySeeded == false)
            {
                AddRecordType(id: UUID(), name: "Distance", displayUnit: "m")
                AddRecordType(id: UUID(), name: "Weight", displayUnit: "lbs")
                AddRecordType(id: UUID(), name: "Time", displayUnit: "")
                AddRecordType(id: UUID(), name: "Repetition", displayUnit: "reps")
                
            }
            do {
                try context.save()
            } catch {
                context.rollback()
                print(error.localizedDescription + " in seeding record types")
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
                AddSportType(id: UUID(), name: "Obstacle Course Racing")
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
    
    func getSport(_ name: String, sports: [Sport]) -> Sport {
        return sports.first(where: { $0.name == name})!
    }
    
    func getType(_ name: String,types: [RecordType]) -> RecordType {
        return types.first(where: { $0.name == name})!
    }
    
    func addTimeBasedTemplates(timeType: RecordType, availableSports: [Sport]) {
        let runningSport = getSport("Running", sports: availableSports)
        
        AddRecordTemplate(id: UUID(),
                          title: "10K Run",
                          type: timeType,
                          sport: runningSport )
        AddRecordTemplate(id: UUID(),
                          title: "5K Run",
                          type: timeType,
                          sport: runningSport )
        AddRecordTemplate(id: UUID(),
                          title: "Half-Marathon Run",
                          type: timeType,
                          sport: runningSport )
        AddRecordTemplate(id: UUID(),
                          title: "Marathon Run",
                          type: timeType,
                          sport: runningSport )
        
        let triathlon = getSport("Triathlon", sports: availableSports)
        
        AddRecordTemplate(id: UUID(),
                          title: "Olympic Triathlon",
                          type: timeType,
                          sport: triathlon )
        AddRecordTemplate(id: UUID(),
                          title: "Sprint Triathlon",
                          type: timeType,
                          sport: triathlon )
        AddRecordTemplate(id: UUID(),
                          title: "Xterra Triathlon",
                          type: timeType,
                          sport: triathlon )
        
        let ocr = getSport("Obstacle Course Racing", sports: availableSports)
        
        AddRecordTemplate(id: UUID(),
                          title: "Spartan Sprint",
                          type: timeType,
                          sport: ocr )
        AddRecordTemplate(id: UUID(),
                          title: "Spartan Super",
                          type: timeType,
                          sport: ocr )
        AddRecordTemplate(id: UUID(),
                          title: "Spartan Beast",
                          type: timeType,
                          sport: ocr )
        
        let weightLifting = getSport("Weightlifting", sports: availableSports)
        
        AddRecordTemplate(id: UUID(),
                          title: "Dead-arm hang",
                          type: timeType,
                          sport: weightLifting )
    }
    
    func addWeightBasedTemplates(weightType: RecordType, availableSports: [Sport]) {
        let weightLifting = getSport("Weightlifting", sports: availableSports)
        
        AddRecordTemplate(id: UUID(),
                          title: "Squat",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Deadlift",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Clean",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Clean & Jerk",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Overhead Squat",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Front Squat",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Strict Press",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Push Press",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Bench Press",
                          type: weightType,
                          sport: weightLifting )
        
    }
    
    func addRepetitionBasedTemplates(repType: RecordType, availableSports: [Sport]) {
        let weightLifting = getSport("Weightlifting", sports: availableSports)
        
        AddRecordTemplate(id: UUID(),
                          title: "Pull-up",
                          type: repType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Chin-up",
                          type: repType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Push-up",
                          type: repType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(),
                          title: "Sit-up",
                          type: repType,
                          sport: weightLifting )
    }
    
    func seedStandardRecordTemplates () {
        
        let templateRequest = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
        let templatePredicate = NSPredicate(format: "isTemplate = %@", "true")
        templateRequest.predicate = templatePredicate
        do {
            let templatesAlreadySeeded = try context.fetch(templateRequest).count > 0
            if(templatesAlreadySeeded == false)
            {
                let sportFetchRequest = NSFetchRequest<Sport>(entityName: Sport.entityName)
                let availableSports = try context.fetch(sportFetchRequest)
                
                let recordTypeFetchRequest = NSFetchRequest<RecordType>(entityName: RecordType.entityName)
                let availableTypes = try context.fetch(recordTypeFetchRequest)
                
                let timeType = availableTypes.first(where: { $0.name == "Time"})!
                
                addTimeBasedTemplates(timeType: timeType, availableSports: availableSports)
                
                let repType = availableTypes.first(where: { $0.name == "Repetition"})!
                addRepetitionBasedTemplates(repType: repType, availableSports: availableSports)
                
                let weightType = availableTypes.first(where: { $0.name == "Weight"})!
                addWeightBasedTemplates(weightType: weightType, availableSports: availableSports)
                
                
                do {
                    try context.save()
                } catch {
                    context.rollback()
                    print(error.localizedDescription + " in seeding sport types")
                }
            }
        } catch {}
    }
}
