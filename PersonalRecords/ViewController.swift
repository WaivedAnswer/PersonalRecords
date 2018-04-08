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
    

    var records: [Recordable] = [
        DistanceRecord( title: "Swim Distance", distance: 1500, description: "The longest front-crawl I have ever done"),
        DistanceRecord( title: "Run Distance", distance: 25000, description: "The longest run I have ever done"),
        DistanceRecord( title: "Bike Distance", distance: 108000, description: "The longest bike I have ever done")
        
    ]
    
    @IBAction func test(_ sender: Any) {
    }
    var lastSelectedIndex : Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func AddNew(_ sender: Any) {
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: false)
        }
        
        performSegue(withIdentifier: "EditRecord", sender: nil)
    }
    
    // MARK: UITableViewDelegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            return sections[0].numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "Testing")
        
        let record = controller.object(at: indexPath)
        cell.detailTextLabel?.text = "\(record.recordDescription ?? "") : \(record.distance)m"
        cell.textLabel?.text = "\(record.title)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { _,_,success in
            self.context.delete(self.controller.object(at: indexPath))
            do {
                try self.context.save()
            } catch {
                print("Save failed rolling back")
                self.context.rollback()
            }
            success(true)
        })
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = true
        return swipeActionConfig
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedIndex = indexPath.row
        performSegue(withIdentifier: "EditRecord", sender: nil)
        
    }
    
    //MARK: FetchController delegates
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            let cell = tableView.cellForRow(at: indexPath!)
            let record = controller.object(at: indexPath!) as! RecordModel
            cell?.detailTextLabel?.text = "\(record.recordDescription ?? "") : \(record.distance)m"
            cell?.textLabel?.text = "\(record.title)"
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    //MARK: Segue stuff
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EditRecord")
        {
            let editVC = segue.destination as! EditRecordViewController
            if let index = tableView.indexPathForSelectedRow {
                editVC.currentRecord = controller.object(at: index)
            }
            
            editVC.context = self.context
        }
        
        if(segue.identifier == "CreateNew")
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
        title = "My Personal Records"
    }
    
    func setupController() {
        let titleSort = NSSortDescriptor(key: #keyPath(RecordModel.title), ascending: true)
        
        let fetchRequest = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
        fetchRequest.sortDescriptors = [titleSort]
        controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                managedObjectContext: context,
                                                sectionNameKeyPath: nil, cacheName: nil)
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

