//
//  Extensions.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-09.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

extension TimeInterval {
    var hours: Int { return Int(self / 3600.0) }
    var minutes: Int { return Int((self / 60.0)) % 60}
    var seconds: Int { return Int(self) % 60}
    var milliseconds: Int { return Int((self - floor(self)) * 1000.0) }
    
    var timeString: String {
        if self.hours != 0 || self.minutes != 0 {
            return String(format: "%02d:%02d:%02d", self.hours, self.minutes, self.seconds, self.milliseconds)}
        else {
            return String(format: "%2d.%02d s", self.seconds, self.milliseconds)
        }
    }
    
    func getTimeInterval(hours: Int, mins: Int, secs: Int , ms : Int = 0) -> TimeInterval? {
        var hrSecs = (Double)(hours) * 3600.0
        var minSecs = (Double)(mins) * 60.0
        var msSecs = (Double)(ms) / 1000.0
        var dsecs = (Double)(secs)
        
        var seconds = hrSecs + minSecs + dsecs + msSecs
        return TimeInterval(exactly: seconds)
    }
}
