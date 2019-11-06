//
//  LeaderboardDataSource.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-10-31.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

class LeaderboardDataSource {
    
    private var items : [LeaderboardItem]
    private let itemComparer : LeaderboardItemComparer
    private let itemService : LeaderboardItemService
    private let currentRecord : RecordModel
    
    init(itemComparer: LeaderboardItemComparer = LargestToSmallestItemComparer(), itemService: LeaderboardItemService,
        currentRecord: RecordModel) {
        items = []
        self.itemComparer = itemComparer
        self.itemService = itemService
        self.currentRecord = currentRecord
        let newItems = itemService.getItems(for: currentRecord.id )
        for item in newItems {
            add(item)
        }
    }
    
    func count() -> Int {
        return items.count
    }
    
    fileprivate func findInsertIndex(for item: LeaderboardItem) -> Int {
        var index = 0
        for existingItem in items {
            if( itemComparer.isBefore(item, existingItem)) {
                return index
            }
            index += 1
        }
        return index
            
    }
    
    func add( _ item : LeaderboardItem) {
        if(items.isEmpty() || itemComparer.isAfter(item, items.last!)) {
            items.append(item)
        } else {
            let index = findInsertIndex(for: item)
            items.insert(item, at: index)
        }
    }
    
    func item( at index: Int ) -> LeaderboardItem? {
        return items[safe: index]
    }
}
