//
//  RecordModelLeaderboardItem.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-10-31.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

class RecordModelLeaderboardItem : LeaderboardItem {
    
    private let record : RecordModel
    private let user: User
    
    init(user: User, record : RecordModel) {
        self.record = record
        self.user = user
    }
    
    func getDisplayName() -> String {
        return user.userName
    }
    
    func getValue() -> Double {
        if let value = record.getCurrentValue() {
            return value
        }
        return 0.0
    }
    
    func getType() -> RecordType {
        return record.getType()
    }
}
