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
    
    init() {
        items = []
    }
    
    func count() -> Int {
        return items.count
    }
    
    fileprivate func findInsertIndex(for item: LeaderboardItem) -> Int {
        var index = 0
        for existingItem in items {
            if( item.getValue() > existingItem.getValue()) {
                return index
            }
            index += 1
        }
        return index
            
    }
    
    func add( _ item : LeaderboardItem) {
        if(items.isEmpty() || item.getValue() < items.last!.getValue()) {
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
