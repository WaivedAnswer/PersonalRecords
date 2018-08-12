//
//  JsonTemplateReaderTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-08-12.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
@testable import PersonalRecords

class JsonTemplateReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJsonReaderReturnsSingleTemplate() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "SingleTemplate", withExtension: ".json")    else {
            XCTFail("Missing file: SingleTemplate.json")
            return
        }
        let subject = JsonTemplateReader()
        
        let templates = subject.readTemplateData(filepath: url)
        
        guard let template = templates.first else {
            XCTFail("Templates are empty!")
            return
        }
        
        XCTAssertEqual(template.title, "BestRecord")
//        XCTAssertEqual(template.id, UUID())
//        XCTAssertEqual(template.sport, Sport.Running)
//        XCTAssertEqual(template.type, RecordType.Time)
        XCTAssertEqual(template.description, "Test template: please ignore")
        
    }
    
}
