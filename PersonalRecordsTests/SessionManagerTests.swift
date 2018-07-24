//
//  SessionManagerTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-07-15.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
@testable import PersonalRecords

class SessionManagerTests: XCTestCase {
    var subject : SessionManager!
    
    override func setUp() {
        super.setUp()
        subject = SessionManager( sessionWriter: MockSessionWriter(), loginChecker: MockLoginChecker(canLogin: true))
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSessionManagerCreatesSessionWithCorrectData() {
        let session = subject.createSessionFor(username: "username", password: "password")
        XCTAssertNotNil(session)
    }
    
    func testNoSessionIsWrittenOnLoginFailure() {
        let mockWriter = MockSessionWriter()
        let subject2 = SessionManager(sessionWriter: mockWriter, loginChecker: MockLoginChecker(canLogin: false))
        let session = subject2.createSessionFor(username: "username", password: "password")
        
        XCTAssertNil(session)
        XCTAssertEqual(session?.sessionData, mockWriter.currentSession?.sessionData)
    }
    
    func testSessionIsWrittenOnCreation() {
        let mockWriter = MockSessionWriter()
        let subject2 = SessionManager(sessionWriter: mockWriter, loginChecker: MockLoginChecker(canLogin: true))
        let session = subject2.createSessionFor(username: "username", password: "password")
        
        XCTAssertEqual(session?.sessionData, mockWriter.currentSession?.sessionData)
    }
    
    func testCurrentSessionReadIsCorrect() {
        let mockWriter = MockSessionWriter()
        let id = "existingSession"
        let existingData = "existingData"
        mockWriter.currentSession = Session(id: id, data: existingData)
        
        let subject2 = SessionManager(sessionWriter: mockWriter, loginChecker: MockLoginChecker(canLogin: true))
        let session = subject2.getCurrentSession()
        
        XCTAssertEqual(id, session?.userId)
    }
    
    func testCurrentSessionReadIsCorrectWhenNoCurrentSession() {
        let mockWriter = MockSessionWriter()
        mockWriter.currentSession = nil
        
        let subject2 = SessionManager(sessionWriter: mockWriter, loginChecker: MockLoginChecker(canLogin: true))
        let session = subject2.getCurrentSession()
        
        XCTAssertNil(session)
    }
    
    func testRemoveCurrentSession() {
        let mockWriter = MockSessionWriter()
        let existingData = "existingData"
        mockWriter.currentSession = Session(id: "existingSession", data: existingData)
        
        let subject2 = SessionManager(sessionWriter: mockWriter, loginChecker: MockLoginChecker(canLogin: false))
        subject2.removeCurrentSession()
        
        XCTAssertNil(mockWriter.currentSession)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
