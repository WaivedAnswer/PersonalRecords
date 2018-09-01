
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
    let timeValueComponentIndex = 0
    let timeTypeComponentIndex = 1
    
    var timeDelegate : CustomTimeDelegate?
    
    private let hourIndex = 0
    private let minuteIndex = 1
    private let secondIndex = 2
    
    private let hourChoices: [Int] = Array(0...99)
    private let minuteChoices: [Int] = Array(0...59)
    private let secondChoices: [Int] = Array(0...59)
    
    private let timeChoices = ["hours", "min", "sec"]
    
    private var selectedHour = 0
    private var selectedMin = 0
    private var selectedSec = 0
    private var selectedType = 0
    
    fileprivate func updateSelection() {

        switch(getSelectedTimeTypeIndex())
        {
        case hourIndex:
            selectRow(selectedHour, inComponent: timeValueComponentIndex, animated: false)
        case minuteIndex:
            selectRow(selectedMin, inComponent: timeValueComponentIndex, animated: false)
        case secondIndex:
            selectRow(selectedSec, inComponent: timeValueComponentIndex, animated: false)
        default:
            break
        }
    }
    
    var timeInterval : TimeInterval { get {
        
        return TimeInterval(
            hours: hourChoices[selectedHour],
            minutes: minuteChoices[selectedMin],
            seconds: secondChoices[selectedSec])
        }
        
        set {
            selectedHour = newValue.hours
            selectedMin = newValue.minutes
            selectedSec = newValue.seconds
            
            updateSelection()
        }
    }
    
    private func getSelectedTimeTypeIndex() -> Int {
        return selectedType
    }
    
    private func getSelectedTimeArray() -> [Int]  {
        switch(getSelectedTimeTypeIndex())
        {
        case hourIndex:
            return hourChoices
        case minuteIndex:
            return minuteChoices
        case secondIndex:
            return secondChoices
        default:
            return []
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
    
    private func updateFromSelected( _ row: Int, inComponent component: Int) {
        switch(component) {
        case timeValueComponentIndex:
            updateSelectedTimeValue( value: row )
        case timeTypeComponentIndex:
            selectedType = row
            self.reloadComponent(timeValueComponentIndex)
            updateSelection()
        default:
            break
        }
        
        timeDelegate?.didUpdateTimeInterval(newtime: self.timeInterval)
    }
    
    override func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        super.selectRow(row, inComponent: component, animated: animated)
        
        updateFromSelected(row, inComponent: component)
    
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateFromSelected(row, inComponent: component)
    }
    
    func setup(){
        self.dataSource = self
        self.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    private func updateSelectedTimeValue(value: Int) {
        
        switch ( getSelectedTimeTypeIndex() )
        {
        case hourIndex:
            selectedHour = value
        case minuteIndex:
            selectedMin = value
        case secondIndex:
            selectedSec = value
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch(component) {
        case timeValueComponentIndex:
            count = getSelectedTimeArray().count
            break
        case timeTypeComponentIndex:
            count = timeChoices.count
            break
        default:
            break
        }
            return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var timeString = ""
        let timeArray = getSelectedTimeArray()
        
        if timeArray.count > row {
            timeString = String(timeArray[row])
        }
        
        switch(component) {
        case timeValueComponentIndex:
            return timeString
        case timeTypeComponentIndex:
            return timeChoices[row]
        default:
            return ""
        }
    }
}
