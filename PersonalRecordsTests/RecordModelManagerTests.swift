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
        context = createMainContext(session: Session(user: User(id: UUID(), userName: "test")), inMemory: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRecordModelManagerCreateRecord() {
        
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Time
        
        let record = subject.createRecordWith(type: expectedType)
        
        XCTAssertNotNil(record)
        XCTAssertEqual(expectedType, RecordType(rawValue: Int(record!.type)))
        XCTAssertFalse(record!.isTemplate())
        
    }
    
    func testRecordModelManagerGetRecord() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Distance
        let record = subject.createRecordWith(type: expectedType)
        
        let result = subject.getRecordBy(id: record!.id)
        XCTAssertNotNil(result)
        XCTAssertEqual(record?.id, result?.id)
    }
    
    func testRecordModelManagerGetsRecordValues() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Distance
        let record = subject.createRecordWith(type: expectedType)
        
        let result = subject.getRecordBy(id: record!.id)
        XCTAssertNotNil(result)
        XCTAssertEqual(record?.id, result?.id)
        XCTAssertEqual(record?.recordValues, result?.recordValues)
    }
    
    func testManagerOnSameUserContextsReturnsExpectedResults() {
        
        let subject = RecordModelManager(mainContext: context)
        
        let expectedType = RecordType.Distance
        let record = subject.createRecordWith(type: expectedType)
        
        let subject2 = RecordModelManager(mainContext: context)
        
        let result = subject2.getRecordBy(id: record!.id)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(record?.id, result?.id)
    }
    
    func testManagerOnDifferentUserContextsReturnsSeparateResults() {
        
        let subject = RecordModelManager(mainContext: context)
        
        let expectedType = RecordType.Distance
        let record = subject.createRecordWith(type: expectedType)
        
        let context2 = createMainContext(session: Session(user: User(id: UUID(), userName: "test")), inMemory: true)
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
        let record = subject.createRecordWith(type: RecordType.Distance)
        
        if let recordId = record?.id {
            XCTAssertTrue(subject.deleteRecordBy(id: recordId))
            XCTAssertNil(subject.getRecordBy(id: recordId))
        }
    }
    
    func testRecordModelManagerDeleteRecordValues() {
        let subject = RecordModelManager(mainContext: context)
        let record = subject.createRecordWith(type: RecordType.Distance)
        XCTAssertNotNil(record)
        let recordId = record!.id
        XCTAssertTrue(subject.deleteRecordValues(forID: recordId))
        let updatedRecord = subject.getRecordBy(id: recordId)
        XCTAssertNotNil(updatedRecord)
        XCTAssertTrue(updatedRecord?.recordValues.count == 0)
    }
    
    func testRecordModelManagerGetRecordWhenManyRecords() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Repetition
        
        let record = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        
        let result = subject.getRecordBy(id: record!.id)
        XCTAssertEqual(record?.id, result?.id)
    }
    
    func testRecordModelManagerGetRecordsByTypePredicate() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Weight
        
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        
        let typePredicate = NSPredicate(format: "%K == %d", "type", Int16(expectedType.rawValue) as CVarArg)
        
        let records = subject.getRecordsWith(predicate: typePredicate)
        XCTAssertEqual(5, records.count)
        XCTAssertEqual(5, records.filter { $0.type == expectedType.rawValue }.count)
    }
    
    func testRecordModelManagerGetRecordsByWhenTypeDoesntExist() {
        let subject = RecordModelManager(mainContext: context)
        let expectedType = RecordType.Weight
        
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        _ = subject.createRecordWith(type: expectedType)
        
        let typePredicate = NSPredicate(format: "%K == %d", "type", RecordType.Time.getValue() as CVarArg)
        
        let records = subject.getRecordsWith(predicate: typePredicate)
        XCTAssertTrue(records.isEmpty)
    }
    
    
}
