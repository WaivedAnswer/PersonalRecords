//
//  TemplateData.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-08-12.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

struct TemplateData {
    init( id: UUID, title: String, type: RecordType, sport: Sport, description: String = "") {
        self.id = id
        self.title = title
        self.type = type
        self.sport = sport
        self.description = description
    }
    var id: UUID
    var title: String
    var type: RecordType
    var sport: Sport
    var description: String
}


