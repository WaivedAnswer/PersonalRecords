//
//  TemplateDataSourceTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-09-01.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
import CoreData
@testable import PersonalRecords

class TemplateDataSourceTests: XCTestCase {
    
    var context : NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        context = createMainContext(for: Session(user: User(id: UUID(), userName: "test")), inMemory: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetCountIsCorrectWhenNoneAreAdded() {
        let subject = TemplateDataSource(context: context)
        XCTAssertEqual(0, subject.getCount())
    }
    
    func testGetCountIsCorrectWhenMultipleAreAdded() {
        let subject = TemplateDataSource(context: context)
        let dataService = DataService(context: context)
        dataService.addRecordTemplate(data: RecordTemplates.BenchPress)
        dataService.addRecordTemplate(data: RecordTemplates.RunMarathon)
        
        XCTAssertEqual(2, subject.getCount())
    }
    
    func testGetTemplateWhenNoTemplatesReturnsNil() {
        let subject = TemplateDataSource(context: context)
        
        XCTAssertNil(subject.getTemplate(row: 0))
    }
    
    func testGetTemplateWhenSingleTemplatesReturnsNil() {
        let subject = TemplateDataSource(context: context)
        let dataService = DataService(context: context)
        dataService.addRecordTemplate(data: RecordTemplates.Squat)
        
        let template = subject.getTemplate(row: 0)
        XCTAssertNotNil( template )
        XCTAssertEqual( RecordTemplates.Squat.id, template?.id )
        XCTAssertEqual( RecordTemplates.Squat.title, template?.title )
    }
    
    func testGetCountIsCorrectWhenMultipleAreAddedWithFilter() {
        let subject = TemplateDataSource(context: context)
        let dataService = DataService(context: context)
        dataService.addRecordTemplate(data: RecordTemplates.BenchPress)
        dataService.addRecordTemplate(data: RecordTemplates.PushPress)
        dataService.addRecordTemplate(data: RecordTemplates.StrictPress)
        dataService.addRecordTemplate(data: RecordTemplates.RunMarathon)
        
        subject.applyFilter(filter: SubstringFilter("Press"))
        XCTAssertEqual(3, subject.getCount())
    }
    
    func testGetCountIsCorrectWhenMultipleAreAddedWhenFiltersAreRemoved() {
        let subject = TemplateDataSource(context: context)
        let dataService = DataService(context: context)
        dataService.addRecordTemplate(data: RecordTemplates.BenchPress)
        dataService.addRecordTemplate(data: RecordTemplates.PushPress)
        dataService.addRecordTemplate(data: RecordTemplates.StrictPress)
        dataService.addRecordTemplate(data: RecordTemplates.RunMarathon)
        
        subject.applyFilter(filter: SubstringFilter("Press"))
        subject.clearAllFilters()
        XCTAssertEqual(4, subject.getCount())
    }
    
    func testGetCountIsCorrectWhenMultipleAreAddedWhenFilterIsReplaced() {
        let subject = TemplateDataSource(context: context)
        let dataService = DataService(context: context)
        dataService.addRecordTemplate(data: RecordTemplates.BenchPress)
        dataService.addRecordTemplate(data: RecordTemplates.PushPress)
        dataService.addRecordTemplate(data: RecordTemplates.StrictPress)
        dataService.addRecordTemplate(data: RecordTemplates.RunMarathon)
        
        subject.applyFilter(filter: SubstringFilter("Press"))
        subject.replaceFilter(filter: SubstringFilter("Run"))
        
        XCTAssertEqual(1, subject.getCount())
    }
    
}
