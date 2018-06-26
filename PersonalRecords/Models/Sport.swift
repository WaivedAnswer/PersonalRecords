//
//  Sport.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-07.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

enum Sport : Int {
    case Running = 0
    case Swimming = 1
    case RoadBiking = 2
    case Triathlon = 3
    case ObstacleCourseRacing = 4
    case Weightlifting = 5
    case Crossfit = 6
    case TrackAndField = 7
    
    static var allSports: [Sport] {
        var values: [Sport] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        return values
    }
}
