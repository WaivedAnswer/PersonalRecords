//
//  Sport.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-07.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

class Sport: NSManagedObject {
    static let entityName = "Sport"
    @NSManaged var name: String
}
