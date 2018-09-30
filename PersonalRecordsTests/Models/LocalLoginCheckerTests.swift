//
//  LocalLoginCheckerTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-09-29.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
@testable import PersonalRecords

class LocalLoginCheckerTests: XCTestCase {
    var subject: LocalLoginChecker!
    var userManager: UserManager!
    override func setUp() {
        super.setUp()
        userManager = UserManager()
        
        subject = LocalLoginChecker(userManager: userManager )
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginFailsWhenUserDoesntExist() {
        let user = subject.login(username: "DoesntExist", password: "TestPassword")
        XCTAssertNil(user)
    }
    
    func testLoginFailsWhenPassWordIsIncorrect() {
        let user = subject.login(username: "Quinn", password: "TestPassword")
        XCTAssertNil(user)
    }
    
    func testLoginSucceedsWhenUserExistsAndCorrectPassword() {
        let user = subject.login(username: "Quinn", password: "Test")
        XCTAssertNotNil(user)
        XCTAssertEqual("Quinn", user?.userName)
    }
    
    func testCreateLoginFailsWhenUserAlreadyExists() {
        let user = subject.createLogin(username: "Quinn", password: "TestPassword")
        XCTAssertNil(user)
    }
    
    func testCreateSucceedsWhenUserDoesntAlreadyExist() {
        let username = "TestUser"
        let user = subject.createLogin(username: username, password: "TestPassword")
        
        XCTAssertNotNil(user)
        XCTAssertEqual(username, user?.userName)
    }
    
}
