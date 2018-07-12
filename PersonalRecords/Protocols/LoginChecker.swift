//
//  LoginChecker.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-11.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

protocol LoginChecker {
    func checkLogin ( username: String, password: String) -> Bool
}
