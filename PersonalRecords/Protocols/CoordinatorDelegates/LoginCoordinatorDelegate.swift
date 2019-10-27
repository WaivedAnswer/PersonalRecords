//
//  LoginCoordinatorDelegate.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-10-19.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

protocol LoginCoordinatorDelegate {
    func didLogin(with session: Session)
}
