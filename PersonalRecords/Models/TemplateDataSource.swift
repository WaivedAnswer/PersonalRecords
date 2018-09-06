//
//  TemplateDataSource.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-01.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

class TemplateDataSource : NSObject, NSFetchedResultsControllerDelegate {
    
    var templates : [RecordModel] = []
    
    var filters : [SubstringFilter] = []
    
    private var controller : NSFetchedResultsController<RecordModel>!
    
    fileprivate func fetchResults() {
        do {
            try controller.performFetch()
            if let fetchedResults =  controller.fetchedObjects {
                templates = fetchedResults.filter(
                    { (model) -> Bool in
                        for filter in filters {
                            if(!model.passes(filter: filter)) {
                                return false;
                            }
                        }
                        return true;
                }
                )
            }
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
    }
    
    private func getFetchRequest() -> NSFetchRequest<RecordModel> {
        let fetchRequest = NSFetchRequest<RecordModel>(entityName: RecordModel.entityName)
        
        fetchRequest.predicate = NSPredicate(format: "isTemplate == TRUE")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(RecordModel.title), ascending: true)]
        
        return fetchRequest
    }
    
    init(context: NSManagedObjectContext) {
        super.init()
        
        let fetchRequest = getFetchRequest()
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        fetchResults()
    }
    
    func applyFilter( filter : SubstringFilter) {
        filters.append(filter)
        fetchResults()
    }
    
    func replaceFilter( filter : SubstringFilter) {
        filters = []
        applyFilter(filter: filter)
    }
    
    func clearAllFilters( ) {
        filters = []
        fetchResults()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fetchResults()
    }
    
    func getCount() -> Int {
        return templates.count
    }
    
    func getTemplate(row: Int) -> RecordModel? {
        if(row < 0 || row >= getCount()) {
            return nil
        }
        
        return templates[row]
    }
    
}
