//
//  RecordModel.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-05.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

protocol Recordable {
    var title: String {get set}
var time: Double {get set}
var distance: Double {get set}
var weight: Double {get set}
var reps: Int32 {get set}
var recordDescription: String? {get set}
var sport: Int16 {get set}
var id: UUID {get set}
var type: Int16 {get set}
var isTemplate: Bool {get set}
}


class RecordModel : NSManagedObject, Recordable {
    static let entityName: String = "RecordModel"
    
    @NSManaged var title: String
    @NSManaged var time: Double
    @NSManaged var distance: Double
    @NSManaged var weight: Double
    @NSManaged var reps: Int32
    @NSManaged var recordDescription: String?
    @NSManaged var sport: Int16
    @NSManaged var id: UUID
    @NSManaged var type: Int16
    @NSManaged var isTemplate: Bool
}

extension RecordModel : Filterable {
    
    private func titlePasses(filter: SubstringFilter) -> Bool {
        return filter.passes(input: title)
    }
    
    func passes(filter: SubstringFilter) -> Bool {
        return titlePasses(filter: filter)
    }
    
}
