//
//  LoginCoordinator.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-10-19.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation
import UIKit

class LoginCoordinator : Coordinator, LoginDelegate {
    
    private let delegate : LoginCoordinatorDelegate
    private let sessionManager : SessionManager
    private let navController : UINavigationController
    
    func start() {
        if let currSession = sessionManager.getCurrentSession() {
            onLogin(session: currSession)
            return
        }
        
        let loginVC = LoginViewController.instantiate()
        loginVC.sessionManager = sessionManager
        loginVC.loginDelegate = self
        self.navController.setNavigationBarHidden(true, animated: false)
        navController.setViewControllers([loginVC], animated: true)
    }
    
    init(navController: UINavigationController, sessionManager: SessionManager, delegate: LoginCoordinatorDelegate) {
        self.delegate = delegate
        self.sessionManager = sessionManager
        self.navController = navController
    }

    
    func onLogin(session: Session) {
        self.navController.setNavigationBarHidden(false, animated: false)
        delegate.didLogin(with: session)
    }
}
