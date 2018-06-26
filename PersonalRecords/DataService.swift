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
    
    func AddRecordTemplate(id: UUID, title: String, type: RecordType, sport: Sport)
    {
        let record = NSEntityDescription.insertNewObject(forEntityName: RecordModel.entityName, into: context) as! RecordModel
        record.title = title
        record.id = id
        record.type = type.rawValue
        record.sport = sport.rawValue
        record.isTemplate = true
    }
    
    func addTimeBasedTemplates(timeType: RecordType) {
        let runningSport = Sport.Running
        
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
        
        let triathlon = Sport.Triathlon
        
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
        
        let ocr = Sport.ObstacleCourseRacing
        
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
        
        let weightLifting = Sport.Weightlifting
        
        AddRecordTemplate(id: UUID(),
                          title: "Dead-arm hang",
                          type: timeType,
                          sport: weightLifting )
    }
    
    func addWeightBasedTemplates(weightType: RecordType) {
        let weightLifting = Sport.Weightlifting
        
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
    
    func addRepetitionBasedTemplates(repType: RecordType) {
        let weightLifting = Sport.Weightlifting
        
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
                
                let timeType = RecordType.Time
                
                addTimeBasedTemplates(timeType: timeType)
                
                let repType = RecordType.Time
                addRepetitionBasedTemplates(repType: repType)
                
                let weightType = RecordType.Weight
                addWeightBasedTemplates(weightType: weightType)
                
                
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
