//
//  DataService.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-08.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

struct DataService {
    private var context: NSManagedObjectContext
    
    init( context: NSManagedObjectContext) {
        self.context = context
    }
    
    func templateExists(id: UUID) -> Bool {
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
    
    func addRecordTemplate(data: TemplateData) {
        addRecordTemplateNoSave(data: data)
        saveContext()
    }
    
    private func addRecordTemplateNoSave(data: TemplateData) {
        if(templateExists(id: data.id)) {
            return
        }
        
        let record = NSEntityDescription.insertNewObject(forEntityName: RecordModel.entityName, into: context) as! RecordModel
        record.title = data.title
        record.id = data.id
        record.type = data.type.getValue()
        record.sport = data.sport.getValue()
        record.isTemplate = true
    }
    
    fileprivate func saveContext() {
        do {
            try context.save()
        } catch {
            context.rollback()
            print(error.localizedDescription + " in seeding templates")
        }
    }
    
    func seedStandardRecordTemplates () {
        for template in RecordTemplates.allTemplates {
            addRecordTemplateNoSave(data: template)
        }
        saveContext()
    }
}
