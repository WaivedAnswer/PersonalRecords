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
        context = createMainContext(session: Session(id: "", data: ""), inMemory: true)
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
        XCTAssertNotNil(result)
        XCTAssertEqual(record?.id, result?.id)
    }
    
    func testManagerOnSameUserContextsReturnsExpectedResults() {
        
        let subject = RecordModelManager(mainContext: context)
        
        let expectedType = RecordType.Distance
        let record = subject.createRecordWith(type: expectedType, isTemplate: false)
        
        let subject2 = RecordModelManager(mainContext: context)
        
        let result = subject2.getRecordBy(id: record!.id)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(record?.id, result?.id)
    }
    
    func testManagerOnDifferentUserContextsReturnsSeparateResults() {
        
        let subject = RecordModelManager(mainContext: context)
        
        let expectedType = RecordType.Distance
        let record = subject.createRecordWith(type: expectedType, isTemplate: false)
        
        let context2 = createMainContext(session: Session(id: "user2", data: "blank"), inMemory: true)
        let subject2 = RecordModelManager(mainContext: context2)
    
        let result = subject2.getRecordBy(id: record!.id)
        
        XCTAssertNil(result)
    }
    
    func testRecordModelManagerGetRecordReturnsNilWhenNoRecords() {
        
        let subject = RecordModelManager(mainContext: context)
        XCTAssertNil(subject.getRecordBy(id: UUID()))
    }
    
    func testRecordModelManagerDeleteRecord() {
        
        let subject = RecordModelManager(mainContext: context)
        let record = subject.createRecordWith(type: RecordType.Distance, isTemplate: false)
        
        if let recordId = record?.id {
            XCTAssertTrue(subject.deleteRecordBy(id: recordId))
            XCTAssertNil(subject.getRecordBy(id: recordId))
        }
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
        
        let typePredicate = NSPredicate(format: "%K == %d", "type", Int16(expectedType.rawValue) as CVarArg)
        
        let records = subject.getRecordsWith(predicate: typePredicate)
        XCTAssertEqual(5, records.count)
        XCTAssertEqual(5, records.filter { $0.type == expectedType.rawValue }.count)
    }
    
    func testRecordModelManagerGetRecordsByWhenTypeDoesntExist() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Weight
        
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        _ = subject.createRecordWith(type: expectedType, isTemplate: false)
        
        let typePredicate = NSPredicate(format: "%K == %d", "type", RecordType.Time.getValue() as CVarArg)
        
        let records = subject.getRecordsWith(predicate: typePredicate)
        XCTAssertTrue(records.isEmpty)
    }
    
    func testRecordModelManagerCopyRecord() {
        let subject = RecordModelManager(mainContext: context)
        
        let newRecord = subject.createRecordWith(type: .Distance, isTemplate: false) as! RecordModel
        newRecord.title = "test"
        newRecord.distance = 500
        newRecord.recordDescription = "This is a cool descirpitoaiohg"
        newRecord.reps = 50
        newRecord.time = 600
        newRecord.weight = 200
        
        let copiedRecord = subject.copyRecord(record: newRecord) as! RecordModel
        
        XCTAssertEqual(newRecord.type, copiedRecord.type)
        XCTAssertEqual(newRecord.sport, copiedRecord.sport)
        
        XCTAssertEqual(newRecord.title, copiedRecord.title)
        XCTAssertEqual(newRecord.isTemplate, copiedRecord.isTemplate)
        XCTAssertEqual(newRecord.recordDescription, copiedRecord.recordDescription)
        XCTAssertEqual(newRecord.time, copiedRecord.time)
        XCTAssertEqual(newRecord.distance, copiedRecord.distance)
        XCTAssertEqual(newRecord.reps, copiedRecord.reps)
        XCTAssertEqual(newRecord.weight, copiedRecord.weight)
        
    }
    
}
