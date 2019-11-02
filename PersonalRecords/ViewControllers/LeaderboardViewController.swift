//
//  LeaderboardViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2019-10-27.
//  Copyright © 2019 Quinnter. All rights reserved.
//

import UIKit

class LeaderboardViewController: UITableViewController, Storyboarded {
    
    var leaderboardDataSource : LeaderboardDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardDataSource.count()
    }
    
    fileprivate func getPlacementString(for index: Int ) -> String {
        return String(index + 1) + ") "
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath)
        
        if let leaderboardItem = leaderboardDataSource.item(at: indexPath.row) {
            cell.textLabel?.text =  getPlacementString(for: indexPath.row) + leaderboardItem.getDisplayName()
            cell.detailTextLabel?.text = leaderboardItem.getDisplayValue()
        }
        
        return cell
    }
    
}
