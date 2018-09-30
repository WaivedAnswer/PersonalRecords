//
//  LoginChecker.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-11.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

protocol LoginService {
    func checkLogin ( username: String, password: String) -> Bool
    func createLogin( username: String, password: String) -> User?
    func login (username: String, password: String ) -> User?
}
