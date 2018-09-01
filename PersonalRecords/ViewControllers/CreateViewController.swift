//
//  CreateViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-07.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var templateDataSource : TemplateDataSource!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return templateDataSource.getCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let template = templateDataSource.getTemplate(row: row) {
            return template.title
        }
        return ""
    }
    
    @IBOutlet weak var TemplatePicker: UIPickerView!
    
    var context: NSManagedObjectContext!
    
    var recordType : RecordType?
    var recordTemplate: RecordModel?
    
    @IBAction func createFromTemplate(_ sender: Any) {
        let row = TemplatePicker.selectedRow(inComponent: 0)
        
        guard let template = templateDataSource.getTemplate(row: row) else {
            fatalError("SelectedTemplate doesn't exist")
        }
        
        self.recordTemplate = template
        self.recordType = RecordType(value: template.type)
        self.performSegue(withIdentifier: "EditNew", sender: nil)
    }
    
    @IBAction func createNew(_ sender: Any) {
        let actions = UIAlertController(title: "Create Custom", message: "Choose a record type", preferredStyle: .actionSheet)
        
        let types = RecordType.allTypes
        for type in types {
            let action = UIAlertAction(title: NSLocalizedString(type.getName(), comment: "\(type.getName()) action"), style: .default) {
                _ in
                self.recordType = type
                self.performSegue(withIdentifier: "EditNew", sender: nil)
                //NSLog("The \"sOK\" alert occured.")
            }
            actions.addAction(action)
        }
        
        
        self.present(actions, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="EditNew")
        {
            let editVC = segue.destination as! EditRecordViewController
            editVC.currentRecordID = self.recordTemplate?.id
            editVC.recordType = self.recordType
            editVC.context = self.context
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        templateDataSource = TemplateDataSource(context: context)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
