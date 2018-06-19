//
//  PersonalRecordsTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-06-13.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import XCTest
import CoreData
@testable import PersonalRecords

class PersonalRecordsTests: XCTestCase {
    var context : NSManagedObjectContext!
    //var subject : EditRecordViewController!
    override func setUp() {
        super.setUp()
        context = createMainContext(inMemory: true)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc: EditRecordViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! EditRecordViewController
//
//        let subject = vc
//        subject.context = createMainContext(inMemory: true)
//
//        _ = subject.view
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRecordModelManagerCreateRecordType() {
        
        let subject = RecordModelManager(mainContext: context)
        let name = "TestType"
        let displayUnit = "m/s"
        
        let type = subject.createRecordTypeWith(name: name, displayUnit: displayUnit)
        
        XCTAssertNotNil(type)
        XCTAssertEqual(name, type!.name)
        XCTAssertEqual(displayUnit, type!.displayUnit)
        
    }
    
    func testRecordModelManagerCreateRecord() {
        
        let subject = RecordModelManager(mainContext: context)
        let expectedType = subject.createRecordTypeWith(name: "TestType", displayUnit: "m/s")
        
        let record = subject.createRecordWith(type: expectedType!, isTemplate: false)
        
        XCTAssertNotNil(record)
        XCTAssertEqual(expectedType, record!.type)
        XCTAssertFalse(record!.isTemplate)

    }
    
    func testRecordModelManagerGetRecord() {
        
        let subject = RecordModelManager(mainContext: context)
        let expectedType = subject.createRecordTypeWith(name: "TestType", displayUnit: "m/s")
        let record = subject.createRecordWith(type: expectedType!, isTemplate: false)

        let result = subject.getRecordBy(id: record!.id)
        XCTAssertEqual(record, result)
    }
    
    func testRecordModelManagerGetRecordWhenManyRecords() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = subject.createRecordTypeWith(name: "TestType", displayUnit: "m/s")
        
        let record = subject.createRecordWith(type: expectedType!, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType!, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType!, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType!, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType!, isTemplate: false)
        
        let result = subject.getRecordBy(id: record!.id)
        XCTAssertEqual(record, result)
    }
    
    func testRecordModelManagerGetRecordsByTypePredicate() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = subject.createRecordTypeWith(name: "TestType", displayUnit: "m/s")
        
        _ = subject.createRecordWith(type: expectedType!, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType!, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType!, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType!, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType!, isTemplate: false)
        
        let typePredicate = NSPredicate(format: "%K == %@", "type", expectedType! as CVarArg)
        
        let records = subject.getRecordsWith(predicate: typePredicate)
        XCTAssertEqual(5, records.count)
        XCTAssertEqual(records, records.filter({ (rm) -> Bool in
            rm.type == expectedType
        }))
    }
    
}
