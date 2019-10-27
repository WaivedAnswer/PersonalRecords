//
//  MainCoordinator.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-10-24.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MainCoordinator : Coordinator, RecordViewDelegate, CreateRecordViewDelegate {
    private let delegate : MainCoordinatorDelegate
    private let session : Session
    private let navController : UINavigationController
    private let mainContext : NSManagedObjectContext
    
    fileprivate func showRecordView() {
        
        let recordViewVC = RecordViewController.instantiate()
        
        recordViewVC.context = mainContext
        recordViewVC.delegate = self
        
        navController.setViewControllers([recordViewVC], animated: true)
    }
    
    fileprivate func seedLatestTemplates() {
        let dataService = TemplateDataService(context: mainContext);
        dataService.seedStandardRecordTemplates()
    }
    
    func start() {
        seedLatestTemplates()
        showRecordView()
    }
    
    init(navController: UINavigationController, session: Session, delegate: MainCoordinatorDelegate) {
        self.delegate = delegate
        self.session = session
        self.navController = navController
        self.mainContext = createMainContext(for: session)
    }

    //MARK: RecordViewDelegates
    func onLogout() {
        delegate.didLogout()
    }
    
    func onSelectRecord(_ selected : RecordModel) {
        showEditRecordView( for: selected)
    }
    
    fileprivate func showEditRecordView(for record: RecordModel ) {
        let editVC = EditRecordViewController.instantiate()
        
        editVC.currentRecord = record
        editVC.context = self.mainContext
        
        navController.pushViewController(editVC, animated: true)
    }
    
    func onAddRecord() {
        showCreateRecordView()
    }
    
    fileprivate func showCreateRecordView() {
        let createVC = CreateViewController.instantiate()
        createVC.context = mainContext
        createVC.delegate = self
        navController.pushViewController(createVC, animated: true)
    }
    
    func onCreateRecord(_ newRecord: RecordModel) {
        showEditRecordView(for: newRecord)
    }
}
