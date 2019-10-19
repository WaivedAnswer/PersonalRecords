//
//  SessionWriter.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-15.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation



class BasicSessionWriter : SessionWriter {
    
    let sessionKey = "session"
    let idKey = "id"
    let usernameKey = "username"
    
    let preferences = UserDefaults.standard
    
    func readCurrentSession() -> Session? {
        if let userData = preferences.object(forKey: sessionKey) as? Dictionary<String, String>,
            let idString = userData[idKey],
            let id = UUID(uuidString: idString),
            let username = userData[usernameKey] {
            
            let user = User(id: id, userName: username)
            return Session(user: user)
        }
        return nil
    }
    
    func writeSessionFor( session: Session ) {
        let user = session.user
        
        var userDataDict = Dictionary<String, String> ()
        
        userDataDict[idKey] = user.userId.uuidString
        userDataDict[usernameKey] = user.userName
        
        
        preferences.set(userDataDict, forKey: sessionKey)
    }
    
    func removeCurrentSession() {
        return preferences.removeObject(forKey: sessionKey)
    }
}
