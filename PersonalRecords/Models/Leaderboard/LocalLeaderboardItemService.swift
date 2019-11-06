//
//  LocalLeaderboardItemService.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-11-02.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import Foundation

class LocalLeaderboardItemService : LeaderboardItemService {
    let userManager : UserManager
    
    init(userManager : UserManager) {
        self.userManager = userManager
    }
    
    func getItems(for recordId: UUID) -> [LeaderboardItem] {
        var items : [LeaderboardItem] = []
        let allLocalUsers = userManager.getAllUsers()
        for localUser in allLocalUsers {
            let userContext = createMainContext(for: localUser)
            let recordManager = RecordModelManager(mainContext: userContext)
            if let userRecord = recordManager.getRecordBy(id: recordId) {
                if(!userRecord.isTemplate()) {
                    items.append( RecordModelLeaderboardItem(user: localUser, record: userRecord))
                }
            }
        }
        return items
    }
}
