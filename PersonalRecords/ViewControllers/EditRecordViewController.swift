//
//  EditRecordViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-03-31.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class EditRecordViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, CustomTimeDelegate,Storyboarded {
    
    private let textFieldDelegate = BasicTextFieldDelegate( transition: nil)
    private var allowableCharacters : AllowableStringValues!
    
    var delegate: EditRecordViewDelegate?
    var currentRecord : RecordModel!
    
    private var picker: CustomTimePicker?
    private var datePicker: UIDatePicker!
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var recordTitle: UILabel!
    
    @IBOutlet weak var recordDate: UITextField!
    
    @IBOutlet weak var recordValue: UITextField!
    
    @objc func saveRecord() {
        updateRecord()
        delegate?.onSave()
    }
    
    private func updateRecord () {
        currentRecord?.title = recordTitle.text!
        
        if let recordValues = currentRecord?.getCurrentValues() {
            recordValues.date = datePicker.date
            switch(currentRecord.getType()) {
            case .Time:
                recordValues.time = picker?.timeInterval ?? 0.0
            case .Distance:
                recordValues.distance = Double(recordValue.text!) ?? 0.0
            case .Repetition:
                recordValues.reps = Int32(recordValue.text!) ?? 0
            case .Weight:
                recordValues.weight = Double(recordValue.text!) ?? 0.0
            }
        }
    }
    
    @objc func onCancel() {
        delegate?.onCancelEdit()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField != recordValue || textField.text == nil) {
            return true
        } else if currentRecord.getType() == .Time {
            return false
        }
        
        var fullText = string
        if let text = textField.text, string == "." {
            fullText = text + string
        }
        return allowableCharacters.AreStringCharactersAllowed(input: fullText)
    }
    
    fileprivate func cancelEdits() {
        recordTitle.endEditing(true)
        recordValue.endEditing(true)
        recordDate.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cancelEdits()
    }
    
    func isDefaultValue( valueText: String) -> Bool {
        return Double(valueText) == 0.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text {
            if isDefaultValue(valueText: text) {
                DispatchQueue.main.async { textField.selectAll(nil) }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func didUpdateTimeInterval(newtime: TimeInterval) {
        recordValue.text = picker?.timeInterval.timeString
    }
    
    fileprivate func updateDateText(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale.current
        let date = datePicker.date
        let text = formatter.string(from: date)
        recordDate.text = text
    }
    
    @objc func handleDatePicker(sender: UIDatePicker){
        updateDateText(sender)
    }
    
    fileprivate func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        datePicker.date = Date()
        datePicker.maximumDate = Date()
        
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -50, to: Date())
        
        datePicker.addTarget(self, action: #selector(self.handleDatePicker(sender: )), for: UIControl.Event.valueChanged)
        updateDateText(datePicker)
        
        recordDate.inputView = datePicker
    }
    
    fileprivate func registerKeyboardHandlers() {
        NotificationCenter.default.addObserver(self, selector: #selector(EditRecordViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditRecordViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    fileprivate func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.onCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.saveRecord))
    }
    
    fileprivate func setupValueInput(_ type: RecordType) {
        switch type {
        case .Time:
            picker = CustomTimePicker()
            if let timeValue = currentRecord?.getCurrentValues()?.time,
                let timePicker = picker {
                timePicker.timeInterval = timeValue
            }
            picker?.timeDelegate = self
            recordValue.inputView = picker
        case .Repetition:
            recordValue.keyboardType = .numberPad
        default:
            recordValue.keyboardType = .decimalPad
        }
        let displayUnit = type.getDisplayUnit()
        
        if !displayUnit.isEmpty() {
            let unitButtonLabel = UIButton()
            unitButtonLabel.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5)
            unitButtonLabel.isUserInteractionEnabled = false
            unitButtonLabel.setTitle(displayUnit, for: .normal)
            unitButtonLabel.setTitleColor(.black, for: .normal)
            unitButtonLabel.backgroundColor = .clear
            
            recordValue.rightView = unitButtonLabel
            recordValue.rightViewMode = .always
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        registerKeyboardHandlers()
        
        allowableCharacters = AllowableStringValues()
        
        let type = currentRecord.getType()
        recordValue.placeholder = type.getName()
        
        setupValueInput(type)
        
        setupDatePicker()
        
        title = currentRecord?.title
        
        recordValue.delegate = self
        
        if let currRecord = currentRecord {
            recordTitle.text = currRecord.title
            if let recordValues = currRecord.getCurrentValues() {
                if let recordDate = recordValues.date {
                    datePicker.date = recordDate
                    updateDateText(datePicker)
                }
                switch currRecord.getType() {
                case .Time:
                    recordValue.text = recordValues.time.timeString
                case .Distance:
                    recordValue.text = String(recordValues.distance)
                case .Repetition:
                    recordValue.text = String(recordValues.reps)
                case .Weight:
                    recordValue.text = String(recordValues.weight)
                }
            }
            
            sportLabel.text = Sport(value: currRecord.sport).getName()
        }
    }
        
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = -keyboardSize.height
         }
     }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.view.frame.origin.y = 0
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

}
