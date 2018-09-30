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
    private let context : NSManagedObjectContext
    
    init(userContext: NSManagedObjectContext ) {
        self.context = userContext
        seedDefaultUsers()
    }
    
    private func add( _ user: User ) -> Bool {
        do {
            let newUser = NSEntityDescription.insertNewObject(
                forEntityName: UserModel.entityName,
                into: context) as! UserModel
        
            newUser.id = user.userId
            newUser.username = user.userName
            
            try context.save()
            
            return true
        } catch {
            context.rollback()
            print (error)
            print("Could not save new record")
            return false
        }
    }
    
    private func seedDefaultUsers() {
        let adminUserNames = [
            User(id: UUID(), userName: "Amanda"),
            User(id: UUID(), userName: "Quinn"),
            User(id: UUID(), userName: "MamaBear"),
            User(id: UUID(), userName: "Dr.Jayyy") ]
        
        for user in adminUserNames {
            if let _ = getUserWith(username: user.userName) {
                continue
            }
            if(!add(user)) {
                assertionFailure("Could not initialize users")
            }
        }
    }
    
    private func translate(userModel : UserModel) -> User {
        return User(id: userModel.id, userName: userModel.username)
    }
    
    func getUserWith(username: String ) -> User? {
        do {
            let request = NSFetchRequest<UserModel>(entityName: UserModel.entityName)
            request.predicate = NSPredicate(format: "%K == %@", "username", username as CVarArg)
            
            let results = try context.fetch(request)
            
            if let userModel = results.first {
                return translate(userModel: userModel)
            }
            
        } catch {
            print(error)
            print("Could not get user")
        }
        
        return nil
        
    }
    
    func addUserWith(username: String) -> User? {
        if let _ = getUserWith(username: username) {
            //user already exists
            return nil
        }
        
        let newUser = User(id: UUID(), userName: username)
        if(!add( newUser )) {
            return nil
        }
        
        return newUser
    }
}
