
//  CustomTimePickerView.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-10.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit

protocol CustomTimeDelegate {
    func didUpdateTimeInterval( newtime: TimeInterval)
}

class CustomTimePicker : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    var timeDelegate : CustomTimeDelegate?
    
    private let hourIndex = 0
    private let minuteIndex = 1
    private let secondIndex = 2
    
    private let hourChoices: [Int] = Array(0...99)
    private let minuteChoices: [Int] = Array(0...59)
    private let secondChoices: [Int] = Array(0...59)
    
    private let timeChoices = ["hours", "min", "sec"]
    
    var timeInterval : TimeInterval { get {
        
        return TimeInterval(
            hours: hourChoices[selectedRow(inComponent: 0)],
            minutes: minuteChoices[selectedRow(inComponent: 1)],
            seconds: secondChoices[selectedRow(inComponent: 2)])
        }
        
        set {
            selectRow(newValue.hours, inComponent: 0, animated: false)
            selectRow(newValue.minutes, inComponent: 1, animated: false)
            selectRow(newValue.seconds, inComponent: 2, animated: false)
        }
    }
    
    init() {
        super.init(frame: CGRect())
        self.setup()
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    
    func setup(){
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component) {
        case 0:
            return hourChoices.count
        case 1:
            return minuteChoices.count
        case 2:
            return secondChoices.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(component) {
        case 0:
            return String(hourChoices[row])
        case 1:
            return String(minuteChoices[row])
        case 2:
            return String(secondChoices[row])
        default:
            return ""
        }
    }
    
    private func updateFromSelected() {
        timeDelegate?.didUpdateTimeInterval(newtime: self.timeInterval)
    }
    
    override func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        super.selectRow(row, inComponent: component, animated: animated)
        updateFromSelected()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateFromSelected()
    }
}

