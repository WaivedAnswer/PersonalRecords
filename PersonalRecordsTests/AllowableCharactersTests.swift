//
//  AllowableCharactersTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-06-20.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
@testable import PersonalRecords

class AllowableCharactersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIntegerNumbersAllowed() {
        let testInput = "12"
        let subject = AllowableStringValues()
        XCTAssertTrue(subject.AreStringCharactersAllowed(input: testInput), testInput + " doesn't pass the expected ruleset")
    }
    
    func testDecimalNumbersAllowed() {
        let testInput = "150.0"
        let subject = AllowableStringValues()
        XCTAssertTrue(subject.AreStringCharactersAllowed(input: testInput), testInput + " doesn't pass the expected ruleset")
    }
    
    func testEndingInDecimalPointNumbersAllowed() {
        let testInput = "15."
        let subject = AllowableStringValues()
        XCTAssertTrue(subject.AreStringCharactersAllowed(input: testInput), testInput + " doesn't pass the expected ruleset")
    }
    
    func testNegativeNumbersNotAllowed() {
        let testInput = "-15"
        let subject = AllowableStringValues()
        XCTAssertFalse(subject.AreStringCharactersAllowed(input: testInput), testInput + " doesn't pass the expected ruleset")
    }
    
    func testCharactersNotAllowed() {
        let testInput = "-15F"
        let subject = AllowableStringValues()
        XCTAssertFalse(subject.AreStringCharactersAllowed(input: testInput), testInput + " doesn't pass the expected ruleset")
    }
    
    func testEmptyStringAllowed() {
        let testInput = ""
        let subject = AllowableStringValues()
        XCTAssertTrue(subject.AreStringCharactersAllowed(input: testInput), testInput + " doesn't pass the expected ruleset")
    }
    
    func testScientificNotAllowed() {
        let testInput = "14e10"
        let subject = AllowableStringValues()
        XCTAssertFalse(subject.AreStringCharactersAllowed(input: testInput), testInput + " doesn't pass the expected ruleset")
    }
    
    
    func testInvalidNumberNotAllowed() {
        let testInput = "14..2"
        let subject = AllowableStringValues()
        XCTAssertFalse(subject.AreStringCharactersAllowed(input: testInput), testInput + " doesn't pass the expected ruleset")
    }
    
}
