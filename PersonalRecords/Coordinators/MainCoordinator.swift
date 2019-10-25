//
//  MainCoordinator.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-10-24.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator, LogoutDelegate {
    private let delegate : MainCoordinatorDelegate
    private let session : Session
    private let navController : UINavigationController
    
    func start() {
        let mainContext = createMainContext(for: session)
        let dataService = DataService(context: mainContext)
        dataService.seedStandardRecordTemplates()
        
        let recordViewVC = RecordViewController.instantiate()
        
        recordViewVC.context = mainContext
        recordViewVC.logoutDelegate = self
        
        navController.setViewControllers([recordViewVC], animated: true)
    }
    
    init(navController: UINavigationController, session: Session, delegate: MainCoordinatorDelegate) {
        self.delegate = delegate
        self.session = session
        self.navController = navController
    }

    
    func onLogout() {
        delegate.didLogout()
    }
}
