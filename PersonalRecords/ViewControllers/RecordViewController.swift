//
//  ViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-03-30.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class RecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSManagedObjectContextDependent, NSFetchedResultsControllerDelegate, Storyboarded {
    
    var controller: NSFetchedResultsController<RecordModel>!
    var context: NSManagedObjectContext!
    weak var delegate: RecordViewDelegate?
    
    private var recordManager : RecordModelManager!
    
    var previousSectionCount : Int = 0
    
    @IBAction func test(_ sender: Any) {
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @objc func onLogout() {
        delegate?.onLogout()
    }
    
    @objc func AddNew() {
        delegate?.onAddRecord()
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
        cell.detailTextLabel?.text = record.getCurrentValueString()
        cell.textLabel?.text = "\(record.title)"
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { _,_,success in
            
            let toDelete = self.controller.object(at: indexPath)
            success(self.recordManager.deleteRecordValues(forID: toDelete.id))
        })
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = true
        return swipeActionConfig
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecord = controller.object(at: indexPath)
        delegate?.onSelectRecord( selectedRecord )
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
        @unknown default:
            // new cases, maybe should do some logging?
            break
        }
    }
    
    //MARK: Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.AddNew))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Logout", style: .plain, target: self, action: #selector(self.onLogout))
        
        setupController()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupController() {
        recordManager = RecordModelManager(mainContext: context)
        
        // #TODO change this predicate, is there some way we can get this info through the record manager?
        let filter = NSPredicate(format: "recordValues.@count != 0")
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
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedPath, animated: true)
        }
    }
    
}
