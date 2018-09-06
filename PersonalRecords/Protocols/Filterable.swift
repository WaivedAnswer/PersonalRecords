//
//  Filterable.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-01.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

protocol Filterable {
    func passes( filter: SubstringFilter) -> Bool
}
