//
//  MoreOptionsViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-17.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit

class MoreOptionsViewController: UIViewController {
    
    var sessionManager : SessionManager!

    @IBAction func onLogout(_ sender: UIButton) {
        sessionManager.removeCurrentSession()
        performSegue(withIdentifier: ViewControllerSegues.LogoutFromMore, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == ViewControllerSegues.LogoutFromMore)
        {
            let loginController = segue.destination as! LoginViewController
            loginController.sessionManager = self.sessionManager
        }
    }

}
