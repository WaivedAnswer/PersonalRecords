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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        self.window = window
        self.appCoordinator = AppCoordinator(window: window)
        
        self.appCoordinator?.start()
        
        return true
    }
    
}

