//
//  RecordValueMigration3-4.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-23.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import CoreData

class RecordValueMigration3to4: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        
        try super.createDestinationInstances(forSource: sInstance, in: mapping, manager: manager)
        
        // create RecordValue
        let recordValues = NSEntityDescription.insertNewObject(forEntityName: RecordValues.entityName, into: manager.destinationContext)
        
        recordValues.setValue( UUID(), forKey:"id")
        recordValues.setValue(sInstance.value(forKey: "time") , forKey:"time")
        recordValues.setValue(sInstance.value(forKey: "distance"), forKey:"distance")
        recordValues.setValue(sInstance.value(forKey: "weight"), forKey:"weight")
        recordValues.setValue(sInstance.value(forKey: "reps"), forKey:"reps")
        
        
        // get destination record
        let destResults = manager.destinationInstances(forEntityMappingName: mapping.name, sourceInstances: [sInstance])
        if let destinationRecordModel = destResults.last  {
            recordValues.setValue(destinationRecordModel, forKey:"record")
        }
        
    }
}
