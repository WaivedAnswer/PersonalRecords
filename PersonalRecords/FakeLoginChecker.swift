//
//  FakeLoginChecker.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-11.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class FakeLoginChecker : LoginChecker {
    
    let adminUserNames = [ "Amanda", "Quinn", "MamaBear", "Dr.Jayyy" ]
    
    let TestPassword = "Test"
    

    
    func checkLogin(username: String, password: String) -> Bool {
        return adminUserNames.contains(username) && password == TestPassword
    }
    
}
