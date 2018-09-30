//
//  SessionWriter.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-15.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

protocol SessionWriter {
    func writeSessionFor( session: Session)
    func readCurrentSession() -> Session?
    func removeCurrentSession()
}
