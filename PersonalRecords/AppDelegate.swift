//
//  AppDelegate.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-03-30.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        self.window = window
        self.appCoordinator = AppCoordinator(window: window)
        
        self.appCoordinator?.start() 
//        let loginController = window?.rootViewController as! LoginViewController

//        let userManager = UserManager(userContext: createUserContext())
//
//        let loginService = LocalLoginChecker(userManager: userManager)
//        let sessionManager = SessionManager(sessionWriter: BasicSessionWriter(), loginService: loginService)
//
//        mainCoordinator = MainCoordinator(sessionManager: sessionManager)
//
//        loginController.sessionManager = sessionManager
//        loginController.coordinator = mainCoordinator!
        
        return true
    }


}

