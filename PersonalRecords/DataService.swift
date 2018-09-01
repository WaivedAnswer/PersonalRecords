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
    
    func templateExists(id: UUID) -> Bool {
        let templateRequest = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
        templateRequest.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        do {
            let request = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
            request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
            let results = try context.fetch(request)
            return !results.isEmpty
        } catch {
            print(error)
            print("Error retrieving templated record.")
            return false
        }
    }
    
    func AddRecordTemplate(id: UUID, title: String, type: RecordType, sport: Sport)
    {
        if(templateExists(id: id)) {
            return
        }
        
        let record = NSEntityDescription.insertNewObject(forEntityName: RecordModel.entityName, into: context) as! RecordModel
        record.title = title
        record.id = id
        record.type = Int16(type.rawValue)
        record.sport = Int16(sport.rawValue)
        record.isTemplate = true
    }
    
    func addTimeBasedTemplates() {
        let runningSport = Sport.Running
        let timeType = RecordType.Time
        AddRecordTemplate(id: UUID(uuidString: "84140b04-7f1f-4b48-b7f5-4da73fddb934")!,
                          title: "10K Run",
                          type: timeType,
                          sport: runningSport )
        AddRecordTemplate(id: UUID(uuidString: "f719cf11-0098-4832-ab74-547a45c0d6b8")!,
                          title: "5K Run",
                          type: timeType,
                          sport: runningSport )
        AddRecordTemplate(id: UUID(uuidString: "29317622-0ffe-46a4-8a7a-0de969bfc68e")!,
                          title: "Half-Marathon Run",
                          type: timeType,
                          sport: runningSport )
        AddRecordTemplate(id: UUID(uuidString: "5d692683-e42b-4210-a114-503a0d455437")!,
                          title: "Marathon Run",
                          type: timeType,
                          sport: runningSport )
        
        let triathlon = Sport.Triathlon
        
        AddRecordTemplate(id: UUID(uuidString: "c4661765-976a-4d50-b2ef-ce5e11b6c112")!,
                          title: "Olympic Triathlon",
                          type: timeType,
                          sport: triathlon )
        AddRecordTemplate(id: UUID(uuidString: "c8f1021c-f107-432e-8613-0f2e1bb16300")!,
                          title: "Sprint Triathlon",
                          type: timeType,
                          sport: triathlon )
        AddRecordTemplate(id: UUID(uuidString: "680f4135-5ed4-4fb5-b1ee-9c3a047a8ecc")!,
                          title: "Xterra Triathlon",
                          type: timeType,
                          sport: triathlon )
        
        let ocr = Sport.ObstacleCourseRacing
        
        AddRecordTemplate(id: UUID(uuidString: "bd1c1cb2-3095-4a2c-8d7e-17f1cfd6fd6c")!,
                          title: "Spartan Sprint",
                          type: timeType,
                          sport: ocr )
        AddRecordTemplate(id: UUID(uuidString: "3257c108-301f-4a07-9ce2-9a581ff3eda8")!,
                          title: "Spartan Super",
                          type: timeType,
                          sport: ocr )
        AddRecordTemplate(id: UUID(uuidString: "6c4c0eb8-92d0-4cca-b907-fb2d171f9636")!,
                          title: "Spartan Beast",
                          type: timeType,
                          sport: ocr )
        
        let weightLifting = Sport.Weightlifting
        
        AddRecordTemplate(id: UUID(uuidString: "a82e38ff-0271-4db3-a1b9-99632703dc6a")!,
                          title: "Dead-arm hang",
                          type: timeType,
                          sport: weightLifting )
    }
    
    func addWeightBasedTemplates() {
        let weightLifting = Sport.Weightlifting
        let weightType = RecordType.Weight
        
        AddRecordTemplate(id: UUID(uuidString: "64a4fba1-a180-4710-9d35-c22a636b765f")!,
                          title: "Squat",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "d40934f1-0968-46f2-bf67-a10571b985c9")!,
                          title: "Deadlift",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "38032843-a8c1-48e1-a81f-d84f5eab07c9")!,
                          title: "Clean",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "e910a054-40fc-401f-9bd0-1e80f3fa6b23")!,
                          title: "Clean & Jerk",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "3ffbc8c9-0e30-48dc-a45b-397cff328e2c")!,
                          title: "Overhead Squat",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "1a3a3e2d-42b4-4aab-a178-88aa785a30ba")!,
                          title: "Front Squat",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "5ea7f4ca-81dd-425b-adec-d6d2fb7a1fa1")!,
                          title: "Strict Press",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "b704fb9d-8f37-4eef-b6ce-0c3386db0a05")!,
                          title: "Push Press",
                          type: weightType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "6b8db684-37ef-431c-bc0a-4a44cf9bbec0")!,
                          title: "Bench Press",
                          type: weightType,
                          sport: weightLifting )
        
    }
    
    func addRepetitionBasedTemplates() {
        let weightLifting = Sport.Weightlifting
        let repType = RecordType.Repetition
        
        AddRecordTemplate(id: UUID(uuidString: "bfeac06a-01f1-4c22-8a0a-4bb22b314512")!,
                          title: "Pull-up",
                          type: repType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "1bd135cf-3472-4875-9837-dd0ae8505c38")!,
                          title: "Chin-up",
                          type: repType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "972947b0-5256-4a64-a057-33ea05c86265")!,
                          title: "Push-up",
                          type: repType,
                          sport: weightLifting )
        AddRecordTemplate(id: UUID(uuidString: "b88b2812-3046-4600-9691-4d39911c098c")!,
                          title: "Sit-up",
                          type: repType,
                          sport: weightLifting )
    }
    
    func seedStandardRecordTemplates () {
        addTimeBasedTemplates()
        addRepetitionBasedTemplates()
        addWeightBasedTemplates()
        do {
            try context.save()
        } catch {
            context.rollback()
            print(error.localizedDescription + " in seeding templates")
        }

    }
}
