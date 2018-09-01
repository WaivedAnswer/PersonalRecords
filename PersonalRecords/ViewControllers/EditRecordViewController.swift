//
//  EditRecordViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-03-31.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class EditRecordViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, NSManagedObjectContextDependent, CustomTimeDelegate {
    private let textFieldDelegate = BasicTextFieldDelegate()
    private var timeLabel : UILabel?
    private var recordManager : RecordModelManager!
    private var allowableCharacters : AllowableStringValues!
    
    private let availableSports: [Sport] = []
    public var context: NSManagedObjectContext!
    
    public var currentRecordID : UUID?
    private var currentRecord : Recordable!
    
    private var picker: CustomTimePicker?
    
    public var recordType : RecordType?
    
    private var isNewRecord : Bool = false
    
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var recordTitle: UITextField!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var recordValue: UITextField!
    
    @IBOutlet weak var recordDescription: UITextView!
    
    @IBAction func saveRecord(_ sender: Any) {
        updateRecord()
        
        do {
            //todo remove save or move to recordmanager
            try context.save()
        } catch {
            context.rollback()
            print (error)
            print("Something went wrong with saving")
        }
        goToHomeScreen()
        
    }
    
    private func updateRecord () {
        currentRecord?.title = recordTitle.text!
        switch(recordType) {
        case .Time?:
            currentRecord?.time = picker?.timeInterval ?? 0.0
        case .Distance?:
            currentRecord?.distance = Double(recordValue.text!) ?? 0.0
        case .Repetition?:
            currentRecord?.reps = Int32(recordValue.text!) ?? 0
        case .Weight?:
            currentRecord?.weight = Double(recordValue.text!) ?? 0.0
        default:
            break
        }
        
        currentRecord?.recordDescription = recordDescription.text
    }
    
    @IBAction func cancelEdit(_ sender: Any) {
        //todo remove rollback or move to recordmanager
        
        context.rollback()
        if(isNewRecord), let id = currentRecord?.id {
            _ = recordManager.deleteRecordBy( id: id)
        }
        goToHomeScreen()
    }
    
    private func goToHomeScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField != recordValue || textField.text == nil) {
            return true
        } else if recordType == .Time {
            return false
        }
        
        var fullText = string
        if let text = textField.text, string == "." {
            fullText = text + string
        }
        return allowableCharacters.AreStringCharactersAllowed(input: fullText)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        recordTitle.endEditing(true)
        recordValue.endEditing(true)
        recordDescription.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            textView.selectAll(nil)
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            textField.selectAll(nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func didUpdateTimeInterval(newtime: TimeInterval) {
        recordValue.text = picker?.timeInterval.timeString
        updateTimeLabelText()
    }
    
    func setupCurrentRecord() {
        if let recordId = currentRecordID {
            isNewRecord = false
            currentRecord = recordManager.getRecordBy(id: recordId)
            recordType = RecordType(rawValue: Int(currentRecord.type))
            //todo populate template
        } else {
            isNewRecord = true
            currentRecord = recordManager.createRecordWith(type: recordType!, isTemplate: false)
        }
        currentRecord?.isTemplate = false
    }
    
    fileprivate func updateTimeLabelText() {
        timeLabel?.text = picker?.timeInterval.timeString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        recordManager = RecordModelManager(mainContext: context)
        allowableCharacters = AllowableStringValues()
        
        setupCurrentRecord()
        
        if let type = recordType {
            valueLabel.text = type.getName()
            if(type == .Time) {
                picker = CustomTimePicker()
                if let value = currentRecord?.time, let timePicker = picker {
                    timePicker.timeInterval = value
                }
                picker?.timeDelegate = self
                recordValue.inputView = picker
                timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
                timeLabel?.textAlignment = .center
                timeLabel?.font = UIFont.systemFont(ofSize: 28)
                timeLabel?.textColor = .black
                timeLabel?.backgroundColor = .lightGray
                timeLabel?.adjustsFontSizeToFitWidth = true
                updateTimeLabelText()
                
                recordValue.inputAccessoryView = timeLabel
                
            }
        }
        
        title = currentRecord?.title
        
        recordValue.delegate = self
        recordTitle.delegate = self
        recordDescription.delegate = self
        
        if let currRecord = currentRecord, let type = RecordType(rawValue: Int(currRecord.type)) {
            recordTitle.text = currRecord.title
            
            switch type {
            case .Time:
                recordValue.text = currRecord.time.timeString
            case .Distance:
                recordValue.text = String(currRecord.distance)
            case .Repetition:
                recordValue.text = String(currRecord.reps)
            case .Weight:
                recordValue.text = String(currRecord.weight)
            }
            
            recordDescription.text = currRecord.recordDescription
            sportTextField.isEnabled = false
            sportTextField.text = Sport(value: currRecord.sport).getName()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
