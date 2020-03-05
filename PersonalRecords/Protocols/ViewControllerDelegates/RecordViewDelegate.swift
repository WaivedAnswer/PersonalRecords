//
//  LogoutDelegate.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-02-18.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

protocol RecordViewDelegate : class {
    func onSelectRecord(_ selected: RecordModel)
    func onAddRecord()
}
