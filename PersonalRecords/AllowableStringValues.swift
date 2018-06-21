//
//  AllowableStringValues.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-06-20.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class AllowableStringValues {
    func AreStringCharactersAllowed( input: String) -> Bool{
        if let doubleVal = Double(input) {
            return doubleVal >= 0.0
        }
        
        return input == ""
    }
}
