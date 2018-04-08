//
//  RecordType.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-08.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

class RecordType : NSManagedObject {
    static let entityName = "RecordType"
    @NSManaged var id: UUID
    @NSManaged var name: String
}
