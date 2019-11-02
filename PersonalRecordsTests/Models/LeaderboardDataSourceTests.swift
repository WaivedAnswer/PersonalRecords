//
//  LeaderboardDataSourceTests.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2019-10-31.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import XCTest
@testable import PersonalRecords

class LeaderboardDataSourceTests: XCTestCase {

    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataSourceIsEmptyByDefault() {
        let subject = LeaderboardDataSource()
        XCTAssertEqual(0, subject.count())
    }
    
    func testDataSourceAdd() {
        let subject = LeaderboardDataSource()
        subject.add( FakeLeaderboardItem())
        XCTAssertEqual( 1, subject.count())
    }
    
    func testDataSourceAddMultiple() {
        let subject = LeaderboardDataSource()
        subject.add( FakeLeaderboardItem())
        subject.add( FakeLeaderboardItem())
        XCTAssertEqual( 2, subject.count())
    }
    
    func testDataSourceAppendMultiple() {
        let subject = LeaderboardDataSource()
        subject.add( FakeLeaderboardItem())
        subject.add( FakeLeaderboardItem())
        XCTAssertEqual( 2, subject.count())
    }
    
    func testDataSourceGetItemForOneItem() {
        let subject = LeaderboardDataSource()
        let originalItem = FakeLeaderboardItem()
        subject.add( originalItem )
        
        let retrievedItem = subject.item(at: 0)
        XCTAssertNotNil(retrievedItem)
        
        XCTAssertEqual( originalItem.getDisplayName(), retrievedItem?.getDisplayName())
        XCTAssertEqual( originalItem.getDisplayValue(), retrievedItem?.getDisplayValue())
    }
    
    func testDataSourceItemsInOrder() {
        let subject = LeaderboardDataSource()
        let smallerItem = FakeLeaderboardItem(value: 2.0)
        let largerItem = FakeLeaderboardItem(value: 15.0)
        subject.add( smallerItem )
        subject.add( largerItem )
        
        let firstItem = subject.item(at: 0)
        XCTAssertNotNil(firstItem)
        XCTAssertEqual(largerItem.getDisplayValue(), firstItem?.getDisplayValue() )
        
        let secondItem = subject.item(at: 1)
        XCTAssertNotNil(secondItem)
        XCTAssertEqual(smallerItem.getDisplayValue(), secondItem?.getDisplayValue())
    }
    
    func testDataSourceItemsInOrderAddedOpposite() {
        let subject = LeaderboardDataSource()
        let smallerItem = FakeLeaderboardItem(value: 2.0)
        let largerItem = FakeLeaderboardItem(value: 15.0)
        subject.add( largerItem )
        subject.add( smallerItem )
        
        let firstItem = subject.item(at: 0)
        XCTAssertNotNil(firstItem)
        XCTAssertEqual(largerItem.getDisplayValue(), firstItem?.getDisplayValue() )
        
        let secondItem = subject.item(at: 1)
        XCTAssertNotNil(secondItem)
        XCTAssertEqual(smallerItem.getDisplayValue(), secondItem?.getDisplayValue())
    }
    
    func testDataSourceItemsInOrderThreeItems() {
        let subject = LeaderboardDataSource()
        let smallestItem = FakeLeaderboardItem(value: 2.0)
        let mediumItem = FakeLeaderboardItem(value: 10.0)
        let largestItem = FakeLeaderboardItem(value: 25.0)
        subject.add( largestItem )
        subject.add( mediumItem )
        subject.add(smallestItem)
        
        let firstItem = subject.item(at: 0)
        XCTAssertNotNil(firstItem)
        XCTAssertEqual(largestItem.getDisplayValue(), firstItem?.getDisplayValue() )
        
        let secondItem = subject.item(at: 1)
        XCTAssertNotNil(secondItem)
        XCTAssertEqual(mediumItem.getDisplayValue(), secondItem?.getDisplayValue())
        
        let thirdItem = subject.item(at: 2)
        XCTAssertNotNil(thirdItem)
        XCTAssertEqual(smallestItem.getDisplayValue(), thirdItem?.getDisplayValue())
    }
    
    func testDataSourceItemsInOrderThreeItemsBackwards() {
        let subject = LeaderboardDataSource()
        let smallestItem = FakeLeaderboardItem(value: 2.0)
        let mediumItem = FakeLeaderboardItem(value: 10.0)
        let largestItem = FakeLeaderboardItem(value: 25.0)
        subject.add( smallestItem )
        subject.add( mediumItem )
        subject.add( largestItem )
        
        let firstItem = subject.item(at: 0)
        XCTAssertNotNil(firstItem)
        XCTAssertEqual(largestItem.getDisplayValue(), firstItem?.getDisplayValue() )
        
        let secondItem = subject.item(at: 1)
        XCTAssertNotNil(secondItem)
        XCTAssertEqual(mediumItem.getDisplayValue(), secondItem?.getDisplayValue())
        
        let thirdItem = subject.item(at: 2)
        XCTAssertNotNil(thirdItem)
        XCTAssertEqual(smallestItem.getDisplayValue(), thirdItem?.getDisplayValue())
    }
    
    func testDataSourceItemsInOrderThreeItemsMediumLast() {
        let subject = LeaderboardDataSource()
        let smallestItem = FakeLeaderboardItem(value: 2.0)
        let mediumItem = FakeLeaderboardItem(value: 10.0)
        let largestItem = FakeLeaderboardItem(value: 25.0)
        
        subject.add( largestItem )
        subject.add( smallestItem )
        subject.add( mediumItem )
        
        let firstItem = subject.item(at: 0)
        XCTAssertNotNil(firstItem)
        XCTAssertEqual(largestItem.getDisplayValue(), firstItem?.getDisplayValue() )
        
        let secondItem = subject.item(at: 1)
        XCTAssertNotNil(secondItem)
        XCTAssertEqual(mediumItem.getDisplayValue(), secondItem?.getDisplayValue())
        
        let thirdItem = subject.item(at: 2)
        XCTAssertNotNil(thirdItem)
        XCTAssertEqual(smallestItem.getDisplayValue(), thirdItem?.getDisplayValue())
    }
    
    
    // TODO ensure leaderboard items are sorted by value
    // ensure leaderboard item formatting is consistent between fakes and reals?
}
