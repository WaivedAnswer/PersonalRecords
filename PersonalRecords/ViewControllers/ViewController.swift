//
//  ViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-03-30.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSManagedObjectContextDependent, NSFetchedResultsControllerDelegate {
    
    
    var controller: NSFetchedResultsController<RecordModel>!
    var context: NSManagedObjectContext!
    
    private var recordManager : RecordModelManager!
    
    var previousSectionCount : Int = 0
    
    @IBAction func test(_ sender: Any) {
    }
    var lastSelectedIndex : Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func AddNew(_ sender: Any) {
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: false)
        }
        
        performSegue(withIdentifier: ViewControllerSegues.MainToCreate, sender: nil)
    }
    
    // MARK: UITableViewDelegates
    
    private func getCurrentSectionCount() -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            previousSectionCount = getCurrentSectionCount()
            return getCurrentSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let currentSection =  sections[section]
            return currentSection.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = controller.sections {
            let currentSection = sections[section]
            if let value = Int16(currentSection.name) {
                return Sport(value: value).getName()
            }
            
        }
        
        return nil
    }
    
    private func getCell() -> UITableViewCell? {
        return tableView.dequeueReusableCell(withIdentifier: "Testing")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        cell = getCell()!
        
        let record = controller.object(at: indexPath)
        
        setCellValues(record: record, cell: cell)
        
        return cell
    }
    
    func setCellValues (record: RecordModel, cell: UITableViewCell ) {
        var valueString: String = ""
        
        if let type = RecordType(rawValue: Int(record.type)), let recordValues = record.getCurrentValues() {
            switch(type) {
            case .Time:
                valueString = recordValues.time.timeString
            case .Distance:
                valueString = String(recordValues.distance)
            case .Repetition:
                valueString = String(recordValues.reps)
            case .Weight:
                valueString = String(recordValues.weight)
            }
            valueString = "\(valueString) \(type.getDisplayUnit())"
        }
        cell.detailTextLabel?.text = valueString
        cell.textLabel?.text = "\(record.title)"
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { _,_,success in
            
            let toDelete = self.controller.object(at: indexPath)
            success(self.recordManager.deleteRecordBy(id: toDelete.id))
        })
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = true
        return swipeActionConfig
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedIndex = indexPath.row
        performSegue(withIdentifier: ViewControllerSegues.MainToEdit, sender: nil)
        
    }
    
    //MARK: FetchController delegates
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if previousSectionCount != getCurrentSectionCount()  {
            if let insertPath = newIndexPath {
                tableView.insertSections(IndexSet(integer: insertPath.section), with: .fade)
            } else if let deletePath = indexPath  {
                tableView.deleteSections(IndexSet(integer: deletePath.section ), with: .fade)
            }
            tableView.reloadData()
            return
        }
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            if let cell = tableView.cellForRow(at: indexPath!) {
                let record = controller.object(at: indexPath!) as! RecordModel
                setCellValues(record: record, cell: cell)
            }
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    //MARK: Segue stuff
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == ViewControllerSegues.MainToEdit)
        {
            let editVC = segue.destination as! EditRecordViewController
            if let index = tableView.indexPathForSelectedRow {
                editVC.currentRecordID = controller.object(at: index).id
                tableView.deselectRow(at: index, animated: false)
            }
            editVC.context = self.context
        }
        
        else if(segue.identifier == ViewControllerSegues.MainToCreate)
        {
            let createVC = segue.destination as! CreateViewController
            createVC.context = self.context
        }
    }
    
    //MARK: Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupController() {
        recordManager = RecordModelManager(mainContext: context)
        
        let filter = NSPredicate(format: "isTemplate == FALSE")
        let fetchRequest = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
        fetchRequest.predicate = filter
        let sportSort = NSSortDescriptor(key: #keyPath(RecordModel.sport), ascending: true)
        let titleSort = NSSortDescriptor(key: #keyPath(RecordModel.title), ascending: true)
        fetchRequest.sortDescriptors = [sportSort, titleSort]
        controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                managedObjectContext: context,
                                                sectionNameKeyPath: #keyPath(RecordModel.sport), cacheName: nil)
        controller.delegate = self
        do {
            try controller.performFetch()
        } catch {
            print("Couldn't load records, try again?")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
