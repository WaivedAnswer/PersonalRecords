//
//  MockAlwaysLoginChecker.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-07-17.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
@testable import PersonalRecords

class MockLoginChecker : LoginChecker {
    var canLogin : Bool
    
    init( canLogin : Bool) {
        self.canLogin = canLogin
    }
    
    func checkLogin(username: String, password: String) -> Bool {
        return canLogin
    }
}
