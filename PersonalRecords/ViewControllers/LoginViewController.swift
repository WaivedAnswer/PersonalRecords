//
//  LoginViewController.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-07-11.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import UIKit
import CoreData

//todo remove context dependent
class LoginViewController: UIViewController, NSManagedObjectContextDependent {
    var context: NSManagedObjectContext!
    
    var loginChecker : LoginChecker!

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onLogin(_ sender: UIButton) {
        guard let username = userNameField.text, let password = passwordField.text else {
            return
        }
    
        if(loginChecker.checkLogin(username: username, password: password)) {
            performSegue(withIdentifier: "Login", sender: nil)
        } else {
            onLoginError();
        }
        
    }
    
    func onLoginError() {
        passwordField.text=""
        let alert = UIAlertController(title: "Login Failed", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "Login")
        {
            let navController = segue.destination as! UINavigationController
            let viewController = navController.viewControllers[0] as! ViewController
            viewController.context = self.context
        }
    }

}
