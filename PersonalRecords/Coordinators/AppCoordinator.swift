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

class AppCoordinator: Coordinator, MainCoordinatorDelegate {
    private let window: UIWindow
    private let navController: UINavigationController
    private var childCoordinators: [Coordinator] = []
    
    func showMainTab() {
        let mainCoordinator = MainCoordinator(navController: navController, delegate: self)
         childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
    
    init(navController: UINavigationController, window: UIWindow) {
        self.window = window
        self.navController = navController
    }
    
    func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()
        showMainTab()
    }
    
    
}
