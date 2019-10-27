//
//  CreateViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-04-07.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, Storyboarded {

    private var templateDataSource : TemplateDataSource!
    
    @IBOutlet weak var SearchResults: UITableView!
    
    private var searchController : UISearchController!
    
    var context: NSManagedObjectContext!
    var delegate: CreateRecordViewDelegate?
    
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
        guard let recordTemplate = templateDataSource.getTemplate(row: indexPath.row) else {
            fatalError("Selected Template doesn't exist")
        }
        
        delegate?.onCreateRecord(recordTemplate)
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
