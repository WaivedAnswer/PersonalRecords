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

class AppCoordinator: Coordinator, LoginCoordinatorDelegate, MainCoordinatorDelegate {
    private let window: UIWindow
    private let sessionManager : SessionManager
    private let navController: UINavigationController
    private var childCoordinators: [Coordinator] = []
    
    func showMainTab(for session: Session) {
        let mainCoordinator = MainCoordinator(navController: navController, session: session, delegate: self)
         childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
    
    fileprivate func showLogin() {
        let loginCoordinator = LoginCoordinator(navController: navController, sessionManager: sessionManager, delegate: self)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    func didLogin(with session: Session) {
        childCoordinators.removeAll(where: { $0 is LoginCoordinator })
        showMainTab(for: session)
    }
    
    func didLogout() {
        sessionManager.removeCurrentSession()
        childCoordinators.removeAll(where: { $0 is MainCoordinator })
        showLogin()
    }
    
    init(navController: UINavigationController, window: UIWindow) {
        self.window = window
        self.navController = navController
        
        let userManager = UserManager(userContext: createUserContext())
        let loginService = LocalLoginChecker(userManager: userManager)
        sessionManager = SessionManager(sessionWriter: BasicSessionWriter(), loginService: loginService)
    }
    
    func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()
        showLogin()
    }
    
    
}
