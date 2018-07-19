//
//  MockSessionWriter.swift
//  PersonalRecordsTests
//
//  Created by Quinn Ramsay on 2018-07-15.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
@testable import PersonalRecords

class MockSessionWriter : SessionWriter {

    var currentSession : Session?
    
    func readCurrentSession() -> String? {
        return currentSession?.sessionData
    }
    func writeSessionFor(session: Session) {
        currentSession = session;
    }
    func removeCurrentSession() {
        currentSession = nil
    }
}
