//
//  TemplateData.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-08-12.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import Unbox

struct TemplateData {
    var id: UUID
    var title: String
    var type: RecordType
    var sport: Sport
    var description: String
}

extension TemplateData: Unboxable {
    init(unboxer: Unboxer) throws {
        self.title = try unboxer.unbox(key: "title")
        self.description = try unboxer.unbox(key: "description")
        self.type = RecordType.Distance
        self.sport = Sport.Crossfit
        self.id = UUID()
    }
}
