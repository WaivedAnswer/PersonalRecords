//
//  FakeLoginChecker.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-11.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class FakeLoginChecker : LoginChecker {
    let FakeUserName = "Amanda"
    let FakePassword = "Test"
    
    let FakeUserName2 = "Quinn"
    let FakePassword2 = "Test"
    
    func checkLogin(username: String, password: String) -> Bool {
        return (username == FakeUserName && password == FakePassword) ||
        (username == FakeUserName2 && password == FakePassword2)
    }
    
}
