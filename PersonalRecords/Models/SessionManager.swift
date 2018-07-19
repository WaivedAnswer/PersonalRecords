//
//  SessionManager.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-14.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class SessionManager {
    let writer : SessionWriter
    let loginChecker : LoginChecker
    init(sessionWriter: SessionWriter, loginChecker: LoginChecker) {
        self.writer = sessionWriter
        self.loginChecker = loginChecker
    }
    
    func getCurrentSession() -> Session? {
        //todo make this string value??
        if let data = writer.readCurrentSession() {
            return Session(id: "NotSure", data: data)
        }
        return nil
    }
    
    func removeCurrentSession() {
        writer.removeCurrentSession()
    }
    
    func createSessionFor(username: String, password: String) -> Session? {
        if( !loginChecker.checkLogin(username: username, password: password)) {
            return nil
        }
        
        let session = Session(id: username, data: "EmptyData")
        writer.writeSessionFor(session: session)
        return session
    }
}
