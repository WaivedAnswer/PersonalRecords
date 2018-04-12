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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return templates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return templates[row].title
    }
    
    var templates : [RecordModel]!
    
    @IBOutlet weak var TemplatePicker: UIPickerView!
    
    var context: NSManagedObjectContext!
    var controller: NSFetchedResultsController<RecordModel>!
    
    var recordType : RecordType?
    var recordTemplate: RecordModel?
    
    @IBAction func createFromTemplate(_ sender: Any) {
        self.recordTemplate = templates[TemplatePicker.selectedRow(inComponent: 0)]
        self.recordType = recordTemplate?.type
        self.performSegue(withIdentifier: "EditNew", sender: nil)
    }
    @IBAction func createNew(_ sender: Any) {
        let actions = UIAlertController(title: "Create Custom", message: "Choose a record type", preferredStyle: .actionSheet)
        
        let typeFetchRequest = NSFetchRequest<RecordType>(entityName: RecordType.entityName)
        let alphabeticalSort = NSSortDescriptor(key: #keyPath(RecordType.name), ascending: true)
        typeFetchRequest.sortDescriptors = [alphabeticalSort]
        
        let types = try! context.fetch(typeFetchRequest)
        for type in types {
            let action = UIAlertAction(title: NSLocalizedString(type.name, comment: "\(type.name) action"), style: .default) {
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
            editVC.currentRecord = self.recordTemplate
            editVC.recordType = self.recordType
            editVC.context = self.context
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTemplates()
        // Do any additional setup after loading the view.
    }
    
    func fetchTemplates() {
        let titleSort = NSSortDescriptor(key: #keyPath(RecordModel.title), ascending: true)
        let filter = NSPredicate(format: "isTemplate == TRUE")
        let fetchRequest = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
        fetchRequest.predicate = filter
        fetchRequest.sortDescriptors = [titleSort]
        do {
            templates = try context.fetch(fetchRequest)
        } catch {
            templates = []
            print("Something went wrong")
        }
        
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
