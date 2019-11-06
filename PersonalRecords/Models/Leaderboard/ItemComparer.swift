//
//  ItemComparer.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-11-02.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

protocol LeaderboardItemComparer {
    func isBefore(_ item: LeaderboardItem, _ existingItem: LeaderboardItem) -> Bool
   func isAfter(_ item: LeaderboardItem, _ existingItem: LeaderboardItem) -> Bool
}

class LargestToSmallestItemComparer : LeaderboardItemComparer {
    func isBefore(_ item: LeaderboardItem, _ existingItem: LeaderboardItem) -> Bool {
        return item.getValue() > existingItem.getValue()
    }
    
    func isAfter(_ item: LeaderboardItem, _ existingItem: LeaderboardItem) -> Bool {
        return item.getValue() < existingItem.getValue()
    }
}

class SmallestToLargestItemComparer : LeaderboardItemComparer {
    func isBefore(_ item: LeaderboardItem, _ existingItem: LeaderboardItem) -> Bool {
        return item.getValue() < existingItem.getValue()
    }
    
    func isAfter(_ item: LeaderboardItem, _ existingItem: LeaderboardItem) -> Bool {
        return item.getValue() > existingItem.getValue()
    }
}
