//
//  FilterableRecordModelTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-09-01.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
import CoreData
@testable import PersonalRecords

class FilterableTemplateTests: XCTestCase {
    
    var context : NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        context = createMainContext(session: Session(user: User(id: UUID(), userName: "test")), inMemory: true)
    }
    
    func testTemplateWithBlankSubstringFilter() {
        let templateDataSource = TemplateDataSource(context: context)
        let dataService = DataService(context: context)
        dataService.addRecordTemplate(data: RecordTemplates.Clean)
        
        let subject = templateDataSource.getTemplate(row: 0)!
        
        let testFilter = SubstringFilter("")
        
        XCTAssertTrue(subject.passes(filter: testFilter))
    }
    
    func testTemplateWithSubstringPartialMatchingTitleFilter() {
        let templateDataSource = TemplateDataSource(context: context)
        let dataService = DataService(context: context)
        dataService.addRecordTemplate(data: RecordTemplates.Clean)
        
        let subject = templateDataSource.getTemplate(row: 0)!
        
        let testFilter = SubstringFilter("Cl")
        
        XCTAssertTrue(subject.passes(filter: testFilter))
    }
    
    func testTemplateWithSubstringMatchingTitleFilter() {
        let templateDataSource = TemplateDataSource(context: context)
        let dataService = DataService(context: context)
        dataService.addRecordTemplate(data: RecordTemplates.Clean)
        
        let subject = templateDataSource.getTemplate(row: 0)!
        
        let testFilter = SubstringFilter("Clean")
        
        XCTAssertTrue(subject.passes(filter: testFilter))
    }
    
    func testTemplateWithSubstringNotMatchingTitleFilter() {
        let templateDataSource = TemplateDataSource(context: context)
        let dataService = DataService(context: context)
        dataService.addRecordTemplate(data: RecordTemplates.Clean)
        
        let subject = templateDataSource.getTemplate(row: 0)!
        
        let testFilter = SubstringFilter("Not")
        
        XCTAssertFalse(subject.passes(filter: testFilter))
    }
    
}
