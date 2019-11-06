//
//  BasicLeaderboardItem.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-10-31.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

class FakeLeaderboardItem : LeaderboardItem {
    private let value : Double
    private let displayName : String
    private let type : RecordType
    
    fileprivate static func generateUsername() -> String {
        return "Test User " + String(Int.random(in: 0...10))
    }
    
    fileprivate static func generateValue( starter: Double) -> Double {
        return starter * Double.random(in: 0.8...1.05)
    }
    
    convenience init() {
        self.init(type: RecordType.Weight)
    }
    
    convenience init(value: Double) {
        self.init(value: value, type: RecordType.Weight)
    }
    
    convenience init(type: RecordType) {
        self.init(starter: 100, type: type)
    }
    
    convenience init(starter: Double, type: RecordType) {
        self.init(value: FakeLeaderboardItem.generateValue(starter: starter), type: type)
    }
    
    init(value: Double, type: RecordType) {
        self.value = value
        self.displayName = FakeLeaderboardItem.generateUsername()
        self.type = type
    }
    
    func getType() -> RecordType {
        return self.type
    }
    func getDisplayName() -> String {
        return displayName
    }
    
    func getValue() -> Double {
        return value
    }
}
