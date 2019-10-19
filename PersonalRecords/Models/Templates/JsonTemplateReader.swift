//
//  JsonTemplateReader.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-08-12.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation
import Unbox

class JsonTemplateReader {

    func readTemplateData(filepath: URL) -> [TemplateData] {
        do {
            let data = try Data(contentsOf: filepath, options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! Dictionary<String, AnyObject>
            let template: TemplateData = try unbox(dictionary: jsonResult)
            return [template]
        } catch {
            return []
        }
       
    }
}
