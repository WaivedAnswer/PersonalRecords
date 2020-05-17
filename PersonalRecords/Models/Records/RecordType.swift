//
//  RecordType.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-08.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

enum RecordType : Int {
    case Distance = 0
    case Weight = 1
    case Time = 2
    case Repetition = 3
    
    static var allTypes: [RecordType] {
        var values: [RecordType] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        return values
    }
}

extension RecordType {
    
    init( value : Int16 ) {
        self.init(rawValue: Int(value))!
    }
    
    func getValue() -> Int16 {
        return Int16(self.rawValue)
    }
    
    func getDisplayUnit() -> String {
        switch(self) {
        case .Time:
            return ""
        case .Distance:
            return "m"
        case .Repetition:
            return "reps"
        case .Weight:
            return "lbs"
        }
    }
    
    func getName() -> String {
        switch(self) {
        case .Time:
            return "Time"
        case .Distance:
            return "Distance"
        case .Repetition:
            return "Repetitions"
        case .Weight:
            return "Weight"
        }
    }
}


