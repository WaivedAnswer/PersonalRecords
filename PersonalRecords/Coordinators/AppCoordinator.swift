//
//  AppCoordinator.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-02-17.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AppCoordinator: Coordinator, LoginDelegate, LogoutDelegate {
    private let window: UIWindow
    private let sessionManager : SessionManager
    private var currentSession : Session?
    private var mainContext : NSManagedObjectContext?
    private let rootViewController: UINavigationController
    
    func createMainTab(session: Session) {
        mainContext = createMainContext(session: session)
        let dataService = DataService(context: mainContext!)
        dataService.seedStandardRecordTemplates()
        
        let mainTabVC = MainTabController.instantiate()
        let navController = mainTabVC.viewControllers?[0] as! UINavigationController
        let recordViewVC = navController.viewControllers[0] as! RecordViewController
        recordViewVC.context = mainContext
        recordViewVC.logoutDelegate = self
        
        rootViewController.pushViewController(recordViewVC, animated: true)
        window.rootViewController = rootViewController
    }
    
    func updateRootController() {
        if let session = currentSession {
            createMainTab(session: session)
        } else {
            let loginVC = LoginViewController.instantiate()
            loginVC.sessionManager = sessionManager
            loginVC.loginDelegate = self
            window.rootViewController = loginVC
        }
        
    }
    
    func onLogin(session: Session) {
        currentSession = session
        
        updateRootController()
    }
    
    func onLogout() {
        currentSession = nil
        sessionManager.removeCurrentSession()
        updateRootController()
    }
    
    init(window: UIWindow) {
        self.window = window
        
        let userManager = UserManager(userContext: createUserContext())
        let loginService = LocalLoginChecker(userManager: userManager)
        sessionManager = SessionManager(sessionWriter: BasicSessionWriter(), loginService: loginService)
        sessionManager.removeCurrentSession()
        
        rootViewController = UINavigationController()
    }
    
    func start() {
        updateRootController()
        window.makeKeyAndVisible()
    }
    
    
}
