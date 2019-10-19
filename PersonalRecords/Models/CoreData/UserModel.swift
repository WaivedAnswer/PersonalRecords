//
//  UserModel.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-29.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

class UserModel : NSManagedObject {
    static let entityName: String = "UserModel"
    @NSManaged var id : UUID
    @NSManaged var username: String
}
