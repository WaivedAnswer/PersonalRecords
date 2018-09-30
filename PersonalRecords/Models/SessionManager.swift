//
//  SessionManager.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-14.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

class SessionManager {
    private let writer : SessionWriter
    private let loginService : LoginService
    
    init(sessionWriter: SessionWriter, loginService: LoginService) {
        self.writer = sessionWriter
        self.loginService = loginService
    }
    
    func getCurrentSession() -> Session? {
        return  writer.readCurrentSession()
    }
    
    func removeCurrentSession() {
        writer.removeCurrentSession()
    }
    
    private func createSessionFor(user: User) -> Session {
        let session = Session(user: user)
        writer.writeSessionFor(session: session)
        return session
    }
    
    func createSessionForExisting(username: String, password: String) -> Session? {
        guard let user = loginService.login(username: username, password: password) else {
            return nil
        }
        
        return createSessionFor(user: user)
    }
    
    func createSessionForNew(username: String, password: String) -> Session? {
        guard let user = loginService.createLogin(username: username, password: password) else {
            return nil
        }
        
        return createSessionFor(user: user)
    }
}
