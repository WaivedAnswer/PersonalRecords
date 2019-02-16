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
class LoginViewController: UIViewController, TransitionDelegate {

    private var passwordFieldDelegate : BasicTextFieldDelegate!
    
    private var context: NSManagedObjectContext!
    
    var sessionManager : SessionManager!
    
    @IBOutlet weak var userNameField: UITextField!
    private let userNameTextDelegate : UITextFieldDelegate = BasicTextFieldDelegate(transition: nil)
    private var passwordTextDelegate : UITextFieldDelegate!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    @IBAction func onLogin(_ sender: UIButton) {
        onLoginInternal()
    }
    @IBAction func onCreate(_ sender: UIButton) {
        onCreateLogin()
    }
    
    func onTransition() {
        onLoginInternal()
    }
    
    private func onLoginInternal() {
        guard let username = userNameField.text,
            let password = passwordField.text,
            let session = sessionManager.createSessionForExisting(username: username, password: password ) else {
                onLoginError(errorTitle: "Login Failed", errorMessage: "Please try again.")
                return;
        }
        
        login(session: session)
    }
    
    func onCreateLogin() {
        guard let username = userNameField.text,
            let password = passwordField.text,
            let session = sessionManager.createSessionForNew(username: username, password: password ) else {
                onLoginError(errorTitle: "Create Login Failed", errorMessage: "Please try again.")
                return;
        }
    
        login(session: session)
    }
    
    private func createAndSeedContext(session: Session) {
        context = createMainContext(session: session)
        
        let dataService = DataService(context: context)
        dataService.seedStandardRecordTemplates()
    }
    
    private func login(session: Session) {
        createAndSeedContext(session: session)
        performSegue(withIdentifier: ViewControllerSegues.LoginToMain, sender: nil)
    }
    
    private func onLoginError(errorTitle: String, errorMessage: String) {
        passwordField.text=""
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        passwordTextDelegate = BasicTextFieldDelegate(transition: self)
        userNameField.delegate = userNameTextDelegate
        passwordField.delegate = passwordTextDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
        
    @objc func keyboardWillShow(notification: NSNotification) {
         if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
             if self.view.frame.origin.y == 0 {
                 self.view.frame.origin.y -= keyboardSize.height/2
             }
         }
     }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let current = sessionManager.getCurrentSession() {
            login(session: current)
        }
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
        if(segue.identifier == ViewControllerSegues.LoginToMain)
        {
            let tabController = segue.destination as! UITabBarController

            let navController = tabController.viewControllers?[0] as! UINavigationController
            let viewController = navController.viewControllers[0] as! ViewController
            
            let moreController = tabController.viewControllers?[1] as! MoreOptionsViewController
            moreController.sessionManager = self.sessionManager
            
            viewController.context = self.context
        }
    }

}
