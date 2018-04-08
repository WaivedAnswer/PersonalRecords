//
//  CreateViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-07.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UIViewController {

    var context: NSManagedObjectContext!
    var recordType : RecordType?
    
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
        
//        let distanceAction = UIAlertAction(title: NSLocalizedString("Distance", comment: "Distance action"), style: .default) {
//            _ in
//            //self.recordType = .Distance
//            self.performSegue(withIdentifier: "EditNew", sender: nil)
//            //NSLog("The \"sOK\" alert occured.")
//        }
//        let repetitionAction = UIAlertAction(title: NSLocalizedString("Repetition", comment: "Repetition action"), style: .default) {
//            _ in
//            //self.recordType = .Repetition
//            self.performSegue(withIdentifier: "EditNew", sender: nil)
//            //NSLog("The \"OK\" alert occured.")
//        }
//        let timeAction = UIAlertAction(title: NSLocalizedString("Time", comment: "Time action"), style: .default) {
//            _ in
//            //self.recordType = .Time
//            self.performSegue(withIdentifier: "EditNew", sender: nil)
//            //NSLog("The \"OK\" alert occured.")
//        }
//        let weightAction = UIAlertAction(title: NSLocalizedString("Weight", comment: "Weight action"), style: .default) {
//            _ in
//            //self.recordType = .Weight
//            self.performSegue(withIdentifier: "EditNew", sender: nil)
//            //NSLog("The \"OK\" alert occured.")
//        }
        
//        actions.addAction(distanceAction)
//        actions.addAction(repetitionAction)
//        actions.addAction(timeAction)
//        actions.addAction(weightAction)
        
        
        self.present(actions, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="EditNew")
        {
            let editVC = segue.destination as! EditRecordViewController
            editVC.recordType = self.recordType
            editVC.context = self.context
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
