//
//  RecordValueMigration3-4.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-23.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import CoreData

class RecordMapping4To5: NSEntityMigrationPolicy {
    
    fileprivate func PreventTemplateValuesFromMigrating(
        migrationManager: NSMigrationManager,
        migrationMapping: NSEntityMapping) throws {
        
        let sourceContext = migrationManager.sourceContext
        
        let templateValuesFetch = NSFetchRequest<NSManagedObject>(entityName: RecordValues.entityName)
        
        templateValuesFetch.predicate = NSPredicate(format: "record.isTemplate == TRUE")
        let results = try sourceContext.fetch(templateValuesFetch)
        results.forEach(sourceContext.delete)
    }
    
    override func begin(_ mapping: NSEntityMapping, with manager: NSMigrationManager) throws {
        
        try PreventTemplateValuesFromMigrating(
            migrationManager: manager,
            migrationMapping: mapping)
        
        try super.begin(mapping, with: manager)
        
    }
}
