//
//  UserManager.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-28.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import CoreData

class UserManager {
    //private let context : NSManagedObjectContext
    var users : [User]
    init(/*userContext: NSManagedObjectContext */) {
        //context = userContext
        self.users = [];
        seedDefaultUsers();
    }
    
    private func seedDefaultUsers() {
        let adminUserNames = [
            User(id: UUID(), userName: "Amanda"),
            User(id: UUID(), userName: "Quinn"),
            User(id: UUID(), userName: "MamaBear"),
            User(id: UUID(), userName: "Dr.Jayyy") ]
        // add passwords to keychain?
        users.append(contentsOf: adminUserNames)
        
    }
    
    func getUserWith(username: String ) -> User? {
        
        return users.first(where: { (user) -> Bool in
            user.userName == username
        })
    }
    
    func addUserWith(username: String) -> User? {
        if let _ = getUserWith(username: username) {
            //user already exists
            return nil
        }
        let newUser = User(id: UUID(), userName: username)
        users.append(newUser)
        
        return newUser
    }
}
