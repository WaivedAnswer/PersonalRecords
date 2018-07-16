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
        let mockWriter = MockSessionWriter()
        subject = SessionManager( sessionWriter: mockWriter)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSessionManagerCreatesSessionWithCorrectData() {
        let testData = "TestData"
        let session = subject.createSessionFor(id: "TestId", data: testData)
        XCTAssertEqual(session.sessionData, testData)
    }
    
    func testSessionIsWrittenOnCreation() {
        let mockWriter = MockSessionWriter()
        let subject2 = SessionManager(sessionWriter: mockWriter)
        let session = subject2.createSessionFor(id: "TestId", data: "TestData")
        
        XCTAssertEqual(session.sessionData, mockWriter.currentSession?.sessionData)
    }
    
    func testCurrentSessionReadIsCorrect() {
        let mockWriter = MockSessionWriter()
        let existingData = "existingData"
        mockWriter.currentSession = Session(id: "existingSession", data: existingData)
        
        let subject2 = SessionManager(sessionWriter: mockWriter)
        let session = subject2.getCurrentSession()
        
        XCTAssertEqual(existingData, session?.sessionData)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
