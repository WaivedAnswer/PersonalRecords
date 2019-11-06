//
//  LeaderboardItemDataService.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-11-02.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

protocol LeaderboardItemService {
    func getItems(for recordId: UUID) -> [LeaderboardItem]
}

class FakeLeaderboardItemService : LeaderboardItemService {
    
    let originalRecord : RecordModel
    
    init( originalRecord: RecordModel) {
        self.originalRecord = originalRecord
    }
    
    func getItems(for recordId: UUID) -> [LeaderboardItem] {
        var items : [LeaderboardItem] = []
        for _ in 0...10 {
            items.append(FakeLeaderboardItem(starter: originalRecord.getCurrentValue() ?? 100.0, type: originalRecord.getType() ))
        }
        return items
    }
}
