//
//  FakeLoginChecker.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-11.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class FakeLoginChecker : LoginChecker {
    let FakeUserName = "Test"
    let FakePassword = "Testing"
    
    func checkLogin(username: String, password: String) -> Bool {
        return username == FakeUserName && password == FakePassword
    }
    
}
