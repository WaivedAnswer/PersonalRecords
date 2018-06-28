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
        XCTAssertEqual(2, subject.numberOfComponents)
    }
    
    func testTimePickerHasCorrectComponents() {
        let subject2 = CustomTimePicker()
        let expectedTime = 3983.0
        subject2.timeInterval = expectedTime
        
        subject2.selectRow(0, inComponent: subject2.timeTypeComponentIndex, animated: false)
        XCTAssertEqual(1, subject2.selectedRow(inComponent: subject2.timeValueComponentIndex))
        
        subject2.selectRow(1, inComponent: subject2.timeTypeComponentIndex, animated: false)
        XCTAssertEqual(6, subject2.selectedRow(inComponent: subject2.timeValueComponentIndex))
        
        subject2.selectRow(2, inComponent: subject2.timeTypeComponentIndex, animated: false)
        XCTAssertEqual(23, subject2.selectedRow(inComponent: subject2.timeValueComponentIndex))
    }
    
    func testTimePickerHasCorrectValueComponent() {
        let expectedTime = 3983.0
        subject.timeInterval = expectedTime
        
        subject.selectRow(0, inComponent: subject.timeTypeComponentIndex, animated: false)
        XCTAssertEqual(0, subject.selectedRow(inComponent: subject.timeTypeComponentIndex))
        
        subject.selectRow(1, inComponent: subject.timeTypeComponentIndex, animated: false)
        XCTAssertEqual(1, subject.selectedRow(inComponent: subject.timeTypeComponentIndex))
        
        subject.selectRow(2, inComponent: subject.timeTypeComponentIndex, animated: false)
        XCTAssertEqual(2, subject.selectedRow(inComponent: subject.timeTypeComponentIndex))
    }
    
    func testTimePickerHasCorrectNumberOfRowsInTypeComponent() {
        XCTAssertEqual(3, subject.numberOfRows(inComponent: subject.timeTypeComponentIndex))
    }
    
    func testTimePickerHasCorrectNumberOfRowsInValueComponent() {
        subject.selectRow(0, inComponent: subject.timeTypeComponentIndex, animated: false)
        XCTAssertEqual(100, subject.numberOfRows(inComponent: subject.timeValueComponentIndex))
        
        subject.selectRow(1, inComponent: subject.timeTypeComponentIndex, animated: false)
        XCTAssertEqual(60, subject.numberOfRows(inComponent: subject.timeValueComponentIndex))
        
        subject.selectRow(2, inComponent: subject.timeTypeComponentIndex, animated: false)
        XCTAssertEqual(60, subject.numberOfRows(inComponent: subject.timeValueComponentIndex))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
