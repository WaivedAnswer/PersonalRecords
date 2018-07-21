//
//  TextFieldHelpers.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-20.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit

class BasicTextFieldDelegate : NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
