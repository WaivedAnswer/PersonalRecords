//
//  StringFilter.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-01.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class SubstringFilter {
    private let substring : String
    
    init(_ substring : String) {
        self.substring = substring
    }
    
    func passes( input: String ) -> Bool {
        return substring.isEmpty || input.localizedCaseInsensitiveContains(substring)
    }
}
