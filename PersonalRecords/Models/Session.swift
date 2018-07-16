//
//  Session.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-15.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class Session {
    let userId : String
    let sessionData : String
    
    init (id: String, data: String){
        userId = id
        sessionData = data
    }
}
