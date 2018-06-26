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


