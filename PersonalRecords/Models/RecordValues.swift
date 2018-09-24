//
//  RecordValues.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-23.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

class RecordValues : NSManagedObject {
    static let entityName: String = "RecordValues"
    
    @NSManaged var date: Date?
    @NSManaged var distance: Double
    @NSManaged var id: UUID
    @NSManaged var reps: Int32
    @NSManaged var time: Double
    @NSManaged var weight: Double
    
    @NSManaged var record: RecordModel
}
