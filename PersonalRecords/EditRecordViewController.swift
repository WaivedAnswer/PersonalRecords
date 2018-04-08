//
//  EditRecordViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-03-31.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class EditRecordViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, NSManagedObjectContextDependent, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableSports.count
    }
    
    let availableSports: [Sport] = []
    var context: NSManagedObjectContext!
    
    var currentRecord : RecordModel?
    
    var recordType : RecordType?
    
    var sportPickerView = UIPickerView()
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var recordTitle: UITextField!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var recordValue: UITextField!

    @IBOutlet weak var recordDescription: UITextView!
    
    @IBAction func saveRecord(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField != recordValue) {
            return true
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentRecord = currentRecord ?? NSEntityDescription.insertNewObject(
            forEntityName: RecordModel.entityName,
            into: context) as! RecordModel
        
        //Todo get record type from the current record
        recordType = recordType ?? .Distance
        
        valueLabel.text = String(describing: recordType!)
        title = currentRecord?.title
        
        recordValue.delegate = self
        recordTitle.delegate = self
        recordDescription.delegate = self
        
        if let currRecord = currentRecord {
            recordTitle.text = currRecord.title
            recordValue.text = String(currRecord.distance)
            recordDescription.text = currRecord.recordDescription
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        currentRecord?.title = recordTitle.text!
        currentRecord?.distance = Int32(recordValue.text!) ?? 0
        currentRecord?.recordDescription = recordDescription.text
        //currentRecord?.sport =
        currentRecord?.time = 1500
        do {
            try context.save()
        } catch {
            print (error)
            print("Something went wrong with saving")
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
