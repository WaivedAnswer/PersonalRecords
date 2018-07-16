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
    
    init(sessionWriter: SessionWriter) {
        writer = sessionWriter;
    }
    
    func getCurrentSession() -> Session? {
        //todo make this string value??
        if let data = writer.readCurrentSession() {
            return Session(id: "NotSure", data: data)
        }
        return nil
    }
    
    func createSessionFor(id: String, data: String) -> Session {
        let session = Session(id: id, data: data)
        writer.writeSessionFor(session: session)
        return session
    }
}
