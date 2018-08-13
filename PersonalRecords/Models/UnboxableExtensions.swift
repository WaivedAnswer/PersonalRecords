//
//  UnboxableExtensions.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-08-12.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import Unbox

extension RecordType : UnboxableEnum {
    
}

extension Sport : UnboxableEnum {
    
}

extension UUID : UnboxableByTransform {
    public typealias UnboxRawValue = String
    
    public static func transform(unboxedValue: String) -> UUID? {
        return UUID(uuidString: unboxedValue)
    }
}

extension TemplateData: Unboxable {
    init(unboxer: Unboxer) throws {
        self.title = try unboxer.unbox(key: "title")
        self.description = try unboxer.unbox(key: "description")
        self.type = try unboxer.unbox(key: "recordType")
        self.sport = try unboxer.unbox(key: "sport")
        self.id = try unboxer.unbox(key: "id")
    }
}
