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
            User(id: UUID(uuidString: "6A073C34-66F1-4E9D-8196-AFC25445D382")!, userName: "Amanda"),
            User(id: UUID(uuidString: "C5D04F8D-704E-4391-9E17-11EFDC9C78DF")!, userName: "Quinn"),
            User(id: UUID(uuidString: "2D4978F4-270B-4393-ADE5-8E42BB959ECF")!, userName: "MamaBear"),
            User(id: UUID(uuidString: "04B02CF3-F0B2-47B0-B1AD-163F348BD778")!, userName: "Dr.Jayyy")]
        
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
    
    private func getUserModel(username: String ) -> UserModel? {
        do {
            let request = NSFetchRequest<UserModel>(entityName: UserModel.entityName)
            request.predicate = NSPredicate(format: "%K == %@", "username", username as CVarArg)
            
            let results = try context.fetch(request)
            
            if let userModel = results.first {
                return userModel
            }
            
        } catch {
            print(error)
            print("Could not get user")
        }
        
        return nil
    }
    
//    private func getAllUsers() -> [UserModel] {
//        do {
//            let request = NSFetchRequest<UserModel>(entityName: UserModel.entityName)
//
//            let results = try context.fetch(request)
//
//            return results
//        } catch {
//            print(error)
//            print("Could not get users")
//            return []
//        }
//    }
//
//    private func removeAllUsers() {
//        for user in getAllUsers() {
//            context.delete(user)
//        }
//        do {
//            try context.save()
//        } catch {
//            print(error)
//            print("Could not remove all users")
//        }
//    }
    
    func getUserWith(username: String ) -> User? {
        if let userModel = getUserModel(username: username ) {
            return translate(userModel: userModel)
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
