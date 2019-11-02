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

class MainCoordinator : Coordinator, RecordViewDelegate, CreateRecordViewDelegate, EditRecordViewDelegate {
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
        editVC.delegate = self
        
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
    
    //MARK: CreateRecordViewDelegates
    func onCreateRecord(_ newRecord: RecordModel) {
        if newRecord.isTemplate() {
            let recordManager = RecordModelManager(mainContext: mainContext)
            let newValues = recordManager.createRecordValues(for: newRecord)
            newRecord.recordValues = [newValues]
        }
        showEditRecordView(for: newRecord)
    }
    
    //MARK: EditRecordViewDelegates
    func onCancelEdit() {
        mainContext.rollback()
        goToHomeScreen()
    }
    
    func onSave() {
        do {
            try mainContext.save()
        } catch {
            mainContext.rollback()
            print (error)
            print("Something went wrong with saving")
        }
        goToHomeScreen()
    }
    
    private func goToHomeScreen() {
        navController.popToRootViewController(animated: true)
    }
    
    private func addDummyValues(to leaderboardDataSource : LeaderboardDataSource, type: RecordType) {
        for _ in 0...10 {
            leaderboardDataSource.add(FakeLeaderboardItem(type: type ))
        }
    }
    func onGoToLeaderboard(for record: RecordModel) {
        let leaderboardVC = LeaderboardViewController.instantiate()
        
        let leaderboardDataSource = LeaderboardDataSource()
        leaderboardDataSource.add(RecordModelLeaderboardItem(record: record))
        
        addDummyValues(to: leaderboardDataSource, type: record.getType())
        
        leaderboardVC.leaderboardDataSource = leaderboardDataSource
        
        navController.pushViewController(leaderboardVC, animated: true)
    }
}
