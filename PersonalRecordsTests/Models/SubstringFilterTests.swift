//
//  SubstringFilterTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-09-01.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
@testable import PersonalRecords

class SubstringFilterTests: XCTestCase {
    
    func testBlankInputBlankStringFilter() {
        let input = ""
        let subject = SubstringFilter( "")
        XCTAssertTrue(subject.passes(input: input))
    }
    
    func testRealInputBlankStringFilter() {
        let input = "Testing123"
        let subject = SubstringFilter( "")
        XCTAssertTrue(subject.passes(input: input))
    }
    
    func testNonMatchingInputWithSubstringFilter() {
        let input = "Testing123"
        let subject = SubstringFilter( "abc")
        XCTAssertFalse(subject.passes(input: input))
    }
    
    func testMatchingInputAtEndWithSubstringFilter() {
        let input = "Testingabc"
        let subject = SubstringFilter( "abc")
        XCTAssertTrue(subject.passes(input: input))
    }
    
    func testMatchingInputInMiddleWithSubstringFilter() {
        let input = "Testabcinga"
        let subject = SubstringFilter( "abc")
        XCTAssertTrue(subject.passes(input: input))
    }
    
    func testMatchingInputNonMatchingCaseWithSubstringFilter() {
        let input = "TAbCinga"
        let subject = SubstringFilter( "abc")
        XCTAssertTrue(subject.passes(input: input))
    }
    
}
