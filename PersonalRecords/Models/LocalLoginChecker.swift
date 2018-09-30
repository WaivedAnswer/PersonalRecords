//
//  LocalLoginChecker.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-29.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class LocalLoginChecker : LoginService {
    
    let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func checkLogin(username: String, password: String) -> Bool {
        return userManager.getUserWith(username: username) != nil
    }
    
    func createLogin(username: String, password: String) -> User? {
        //todo store password
        return userManager.addUserWith(username: username)
    }
    
    func login(username: String, password: String) -> User? {
        //todo password verification
        guard let user = userManager.getUserWith(username: username) else {
            return nil
        }
        
        return password == "Test" ? user : nil
        
        
    }
    
    
}
