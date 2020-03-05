//
//  DataServiceTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-09-01.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
import CoreData
@testable import PersonalRecords

class DataServiceTests: XCTestCase {
    var context : NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        context = createRecordContextForTest()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanUpdate10KRunTemplateExists() {
        let subject = TemplateDataService( context: context)
        subject.seedStandardRecordTemplates()
        
        XCTAssertTrue(subject.updateTemplate(data: RecordTemplates.Run10K))
    }
    
    func testTemplateCountIsCorrect() {
        let subject = TemplateDataService( context: context)
        subject.seedStandardRecordTemplates()
        
        var results : [RecordModel] = []
        do {
            let templateRequest = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
            templateRequest.predicate = TemplateDataSource.TEMPLATE_PREDICATE
            results = try context.fetch(templateRequest)
        } catch {
            print(error)
            print("Error retrieving templated record.")
        }
        
        XCTAssertEqual(RecordTemplates.allTemplates.count, results.count)
    }
    
    
}
