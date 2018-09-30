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
    
    var subject : UserManager!
    
    override func setUp() {
        super.setUp()
        subject = UserManager(userContext: createUserContext(inMemory: true))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserManagerIsSeededAndCanGetProperly() {

        let expectedUserName = "Quinn"
        
        let result = subject.getUserWith(username: expectedUserName)
        
        XCTAssertEqual(expectedUserName, result?.userName)
    }
    
    func testGetWhenUserDoesntExist() {
        
        let expectedUserName = "Justin"
        
        let result = subject.getUserWith(username: expectedUserName)
        
        XCTAssertNil(result)
    }
    
    func testAddUser() {
        
        let expectedUserName = "Justin"
        
        let result = subject.addUserWith(username: expectedUserName)
        
        XCTAssertEqual(expectedUserName, result?.userName)
    }
    
    func testGetAfterAddUser() {
        
        let expectedUserName = "Justin"
        
        let _ = subject.addUserWith(username: expectedUserName)
        let result = subject.getUserWith(username: expectedUserName)
        
        XCTAssertEqual(expectedUserName, result?.userName)
    }
    
    func testAddUserFailsWhenBlankString() {
        
        let expectedUserName = ""
        
        let result = subject.addUserWith(username: expectedUserName)
        
        XCTAssertNil(result)
    }
    
    func testAddUserFailsWhenDuplicate() {
        
        let expectedUserName = "Justin"
        
        let _ = subject.addUserWith(username: expectedUserName)
        let result = subject.addUserWith(username: expectedUserName)
        
        XCTAssertNil(result)
    }
    
}
