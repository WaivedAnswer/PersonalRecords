//
//  User.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-28.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class User {
    let userName : String
    let userId : UUID
    
    init(id: UUID, userName: String) {
        self.userId = id
        self.userName = userName
    }
}
