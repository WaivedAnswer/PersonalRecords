//
//  TextFieldHelpers.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-20.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit

class BasicTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    private var delegate : TransitionDelegate?
    
    init( transition: TransitionDelegate?) {
        self.delegate = transition;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.onTransition()
        return true
    }
}
