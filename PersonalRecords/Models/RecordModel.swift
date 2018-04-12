//
//  RecordModel.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-05.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

class RecordModel : NSManagedObject {
    static let entityName: String = "RecordModel"
    @NSManaged var title: String
    @NSManaged var time: Double
    @NSManaged var distance: Double
    @NSManaged var reps: Int32
    @NSManaged var recordDescription: String?
    @NSManaged var sport: Sport?
    @NSManaged var id: UUID
    @NSManaged var type: RecordType
    @NSManaged var isTemplate: Bool
}
