//
//  EditRecordViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-03-31.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class EditRecordViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, NSManagedObjectContextDependent, UIPickerViewDelegate{
    
    private var saveChanges = true
    
    private let availableSports: [Sport] = []
    public var context: NSManagedObjectContext!
    
    public var currentRecord : Recordable?
    private var picker: CustomTimePicker?
    
    public var recordType : RecordType?
    
    private var sportPickerView = UIPickerView()
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var recordTitle: UITextField!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var recordValue: UITextField!

    @IBOutlet weak var recordDescription: UITextView!
    
    @IBAction func saveRecord(_ sender: Any) {
        saveChanges = true
        navigationController?.popToRootViewController(animated: true)
       
    }
    @IBAction func cancelEdit(_ sender: Any) {
        saveChanges = false
        navigationController?.popToRootViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField != recordValue) {
            return true
        } else if recordType?.name == "Time" {
            return false
        }
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            textView.selectAll(nil)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == sportTextField)
        {
            displaySportsPicker()
            return
        }
        DispatchQueue.main.async {
            textField.selectAll(nil)
        }
    }
    
    func displaySportsPicker() {
    }
    
    //Mark: Picker Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker?.pickerView(picker!, titleForRow: row, forComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        recordValue.text = picker?.timeInterval.timeString
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        recordValue.text = picker?.timeInterval.timeString
    }
    
    func setupCurrentRecord() {
        if currentRecord == nil {
            currentRecord = NSEntityDescription.insertNewObject(
                forEntityName: RecordModel.entityName,
                into: context) as? RecordModel
            currentRecord?.id = UUID();
            currentRecord?.type = recordType!
        }
        currentRecord?.isTemplate = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        setupCurrentRecord()
        
        recordType = recordType ?? currentRecord?.type
        
        if let type = recordType {
            valueLabel.text = type.name
            if(type.name == "Time") {
                picker = CustomTimePicker()
                if let value = currentRecord?.time {
                    picker?.setTimeInterval(value)
                }
                picker?.delegate = self
                recordValue.inputView = picker
                
            }
        }
        
        

        
        title = currentRecord?.title
        
        recordValue.delegate = self
        recordTitle.delegate = self
        recordDescription.delegate = self
        
        if let currRecord = currentRecord {
            recordTitle.text = currRecord.title
            switch recordType!.name {
            case "Time":
                recordValue.text = currRecord.time.timeString
            case "Distance":
                recordValue.text = String(currRecord.distance)
            case "Repetition":
                recordValue.text = String(currRecord.reps)
            case "Weight":
                recordValue.text = String(currRecord.weight)
            default:
                break
            }
            if (recordType!.name == "Time") {
                
            } else {
                
            }
            recordDescription.text = currRecord.recordDescription
            sportTextField.isEnabled = false
            if let sport = currRecord.sport {
            sportTextField.text = sport.name
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(saveChanges) {
            currentRecord?.title = recordTitle.text!
            switch(recordType?.name) {
            case "Time":
                currentRecord?.time = picker?.timeInterval ?? 0.0
            case "Distance":
                currentRecord?.distance = Double(recordValue.text!) ?? 0.0
            case "Repetition":
                currentRecord?.reps = Int32(recordValue.text!) ?? 0
            case "Weight":
                currentRecord?.weight = Double(recordValue.text!) ?? 0.0
            default:
                break
            }
            
            currentRecord?.recordDescription = recordDescription.text
            //currentRecord?.sport =
            do {
                try context.save()
            } catch {
                context.rollback()
                print (error)
                print("Something went wrong with saving")
            }
        } else {
            context.rollback()
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
