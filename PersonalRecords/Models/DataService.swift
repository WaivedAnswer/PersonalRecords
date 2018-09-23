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
    
    func updateTemplate(data: TemplateData) -> Bool {
        do {
            let request = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
            request.predicate = NSPredicate(format: "%K == %@", "id", data.id as CVarArg)
            let results = try context.fetch(request)
            if(results.count != 1) {
                return false
            }
            if let template = results.first {
                updateRecordValues(template, data)
            }
            
        } catch {
            print(error)
            print("Error retrieving templated record.")
            return false
        }
        
        return true
    }
    
    func addRecordTemplate(data: TemplateData) {
        addRecordTemplateNoSave(data: data)
        saveContext()
    }
    
    fileprivate func updateRecordValues(_ record: RecordModel, _ data: TemplateData) {
        record.title = data.title
        record.type = data.type.getValue()
        record.sport = data.sport.getValue()
    }
    
    private func addRecordTemplateNoSave(data: TemplateData) {
        if(updateTemplate(data: data)) {
            return
        }
        
        let record = NSEntityDescription.insertNewObject(forEntityName: RecordModel.entityName, into: context) as! RecordModel
        record.id = data.id
        record.isTemplate = true
        updateRecordValues(record, data)
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
