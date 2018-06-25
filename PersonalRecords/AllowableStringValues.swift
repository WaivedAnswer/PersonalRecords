//
//  AllowableStringValues.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-06-20.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class AllowableStringValues {
    
    private func areCharactersNumeric( input: String) -> Bool {
        
        let inputCharacters = CharacterSet.init(charactersIn: input)
        
        let allowableCharacterSet = CharacterSet.decimalDigits.union(CharacterSet.punctuationCharacters)
        
        return allowableCharacterSet.isSuperset(of: inputCharacters)
    }
    
    func AreStringCharactersAllowed( input: String) -> Bool {
        
        if(!areCharactersNumeric(input: input)) {
            return false
        }
        
        if let doubleVal = Double(input) {
            return doubleVal >= 0.0
        }
        
        return input == ""
    }
}
