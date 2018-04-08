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
    @NSManaged var distance: Int32
    @NSManaged var recordDescription: String?
    @NSManaged var sport: Sport
    @NSManaged var time: TimeInterval
}
