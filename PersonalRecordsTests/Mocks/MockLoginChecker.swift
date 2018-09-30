//
//  MockAlwaysLoginChecker.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-07-17.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
@testable import PersonalRecords

class MockLoginChecker : LoginService {
    
    func createLogin(username: String, password: String) -> User? {
        assert(false, "MockLoginChecker cannot support createLogin.")
    }
    
    func login(username: String, password: String) -> User? {
        if canLogin {
            return User(id: UUID(), userName: username)
        }
        return nil
    }
    
    var canLogin : Bool
    
    init( canLogin : Bool) {
        self.canLogin = canLogin
    }
    
    func checkLogin(username: String, password: String) -> Bool {
        return canLogin
    }
    
}
