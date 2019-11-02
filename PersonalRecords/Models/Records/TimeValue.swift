//
//  TimeValue.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-11-01.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

class TimeValue {
    
    let seconds : TimeInterval
    
    init(seconds: Double) {
        self.seconds = seconds
    }
    
    func toString() -> String {
        return seconds.timeString
    }
}
