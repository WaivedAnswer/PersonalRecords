//
//  RecordModel.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-05.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData



class RecordModel : NSManagedObject {
    static let entityName: String = "RecordModel"
    
    @NSManaged var title: String
    @NSManaged var recordValues: NSOrderedSet
    @NSManaged var recordDescription: String?
    @NSManaged var sport: Int16
    @NSManaged var id: UUID
    @NSManaged var type: Int16
}

extension RecordModel : Filterable {
    
    private func titlePasses(filter: SubstringFilter) -> Bool {
        return filter.passes(input: title)
    }
    
    func passes(filter: SubstringFilter) -> Bool {
        return titlePasses(filter: filter)
    }
    
}

extension RecordModel {
    func getCurrentValues() -> RecordValues? {
        return recordValues.firstObject as? RecordValues
    }
    
    func getCurrentValue() -> Double? {
        if let currentValues = self.getCurrentValues() {
            switch getType() {
            case .Time:
                return currentValues.time
            case .Distance:
                return currentValues.distance
            case .Repetition:
                return Double(currentValues.reps)
            case .Weight:
                return currentValues.weight
            }
        }
        return nil
    }
    
    func getCurrentValueString() -> String {
        var valueString = ""
        if let value = getCurrentValue() {
            if(getType() == .Time) {
               valueString = value.timeString
            } else {
               valueString = String(value)
            }
        }
        return "\(valueString) \(getType().getDisplayUnit())"
    }
    
    func isTemplate() -> Bool {
        return recordValues.count == 0
    }
    func getType() -> RecordType {
        return RecordType(value: type)
    }
    func getSport() -> Sport {
        return Sport(value: sport)
    }
}
