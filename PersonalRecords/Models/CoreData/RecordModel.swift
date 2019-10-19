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
    func getCurrentValue() -> RecordValues? {
        return recordValues.firstObject as? RecordValues
    }
    func isTemplate() -> Bool {
        return recordValues.count == 0
    }
}
