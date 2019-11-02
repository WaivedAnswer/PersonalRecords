//
//  LeaderboardItem.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-10-31.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

protocol LeaderboardItem {
    func getType() -> RecordType
    func getDisplayName() -> String
    func getValue() -> Double
}

extension LeaderboardItem {
    func getDisplayValue() -> String {
        var valueString = ""
        if(getType() == .Time) {
            valueString = getValue().timeString
        } else {
            valueString = String(format: "%0.1f",getValue())
        }
        
        return "\(valueString) \(getType().getDisplayUnit())"
    }
}
