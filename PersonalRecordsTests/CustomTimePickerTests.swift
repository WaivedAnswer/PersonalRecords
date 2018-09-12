//
//  CustomTimePickerTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-06-21.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
@testable import PersonalRecords

class CustomTimePickerTests: XCTestCase {
    
    let subject = CustomTimePicker()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTimePickerHasCorrectTimeInterval() {
        let expectedTime = 360.0
        subject.timeInterval = expectedTime
        XCTAssertEqual(expectedTime, subject.timeInterval)
    }
    
    func testTimePickerHasCorrectNumberOfComponents() {
        XCTAssertEqual(3, subject.numberOfComponents)
    }
    
    func testTimePickerHasCorrectComponents() {
        let subject2 = CustomTimePicker()
        let expectedTime = 3983.0
        subject2.timeInterval = expectedTime
    
        XCTAssertEqual(1, subject2.selectedRow(inComponent: 0))
        
        XCTAssertEqual(6, subject2.selectedRow(inComponent: 1))
        
        XCTAssertEqual(23, subject2.selectedRow(inComponent: 2))
    }
    
    
    func testTimePickerHasCorrectNumberOfRowsInValueComponent() {
        
        XCTAssertEqual(100, subject.numberOfRows(inComponent: 0))
        
        XCTAssertEqual(60, subject.numberOfRows(inComponent: 1))
        
        XCTAssertEqual(60, subject.numberOfRows(inComponent: 2))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
