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
    
    func testRecordModelManagerCreateRecord() {
        
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Time
        
        let record = subject.createRecordWith(type: expectedType, isTemplate: false)
        
        XCTAssertNotNil(record)
        XCTAssertEqual(expectedType, RecordType(rawValue: Int(record!.type)))
        XCTAssertFalse(record!.isTemplate)

    }
    
    func testRecordModelManagerGetRecord() {
        
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Distance
        let record = subject.createRecordWith(type: expectedType, isTemplate: false)

        let result = subject.getRecordBy(id: record!.id)
        XCTAssertEqual(record?.id, result?.id)
    }
    
    func testRecordModelManagerGetRecordWhenManyRecords() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Repetition
        
        let record = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        
        let result = subject.getRecordBy(id: record!.id)
        XCTAssertEqual(record?.id, result?.id)
    }
    
    func testRecordModelManagerGetRecordsByTypePredicate() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Weight
        
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        
        let typePredicate = NSPredicate(format: "%K == %@", "type", expectedType.rawValue as CVarArg)
        
        let records = subject.getRecordsWith(predicate: typePredicate)
        XCTAssertEqual(5, records.count)
        XCTAssertEqual(5, records.filter { $0.type == expectedType.rawValue }.count)
    }
    
}
