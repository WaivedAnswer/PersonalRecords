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
    let preferences = UserDefaults.standard
    
    func readCurrentSession() -> String? {
        return preferences.object(forKey: sessionKey) as? String
    }
    
    func writeSessionFor( session: Session ) {
        preferences.set(session.userId, forKey: sessionKey)
    }
    
    func removeCurrentSession() {
        return preferences.removeObject(forKey: sessionKey)
    }
}
