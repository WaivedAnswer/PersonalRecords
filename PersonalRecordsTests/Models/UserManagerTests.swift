//
//  UserManagerTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-09-29.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
@testable import PersonalRecords

class UserManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserManagerIsSeededAndCanGetProperly() {
        let subject = UserManager()
        let expectedUserName = "Quinn"
        
        let result = subject.getUserWith(username: expectedUserName)
        
        XCTAssertEqual(expectedUserName, result?.userName)
    }
    
}
