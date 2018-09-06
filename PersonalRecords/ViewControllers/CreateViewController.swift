//
//  CreateViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-07.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    
    
    private var templateDataSource : TemplateDataSource!
    
    @IBOutlet weak var SearchResults: UITableView!
    
    private var searchController : UISearchController!
    
    var context: NSManagedObjectContext!
    
    private var recordType : RecordType?
    private var recordTemplate: RecordModel?
    
    func numberOfComponents(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ pickerView: UITableView, numberOfRowsInSection component: Int) -> Int {
        return templateDataSource.getCount()
    }
    
    func tableView(_ pickerView: UITableView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let template = templateDataSource.getTemplate(row: row) {
            return template.title
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let template = templateDataSource.getTemplate(row: indexPath.row) else {
            fatalError("SelectedTemplate doesn't exist")
        }
        
        self.recordTemplate = template
        self.recordType = RecordType(value: template.type)
        self.performSegue(withIdentifier: "EditNew", sender: nil)
    }
    
    private func setCellValues(template: RecordModel, cell: UITableViewCell) {
        cell.detailTextLabel?.text = Sport(value: template.sport).getName()
        cell.textLabel?.text = "\(template.title)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //todo replace with dequeue stuff
        
        if let template = templateDataSource.getTemplate(row: indexPath.row) {
            setCellValues(template: template, cell: cell)
        }
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        let filter = SubstringFilter( text )
        templateDataSource.replaceFilter(filter: filter)
        SearchResults.reloadData()
    }
    
    @IBAction func createFromTemplate(_ sender: Any) {
    }
    
    @IBAction func createNew(_ sender: Any) {
        let actions = UIAlertController(title: "Create Custom", message: "Choose a record type", preferredStyle: .actionSheet)
        
        let types = RecordType.allTypes
        for type in types {
            let action = UIAlertAction(title: NSLocalizedString(type.getName(), comment: "\(type.getName()) action"), style: .default) {
                _ in
                self.recordType = type
                self.performSegue(withIdentifier: "EditNew", sender: nil)
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
        
        SearchResults.dataSource = self
        SearchResults.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        SearchResults.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
