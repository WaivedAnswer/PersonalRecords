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
class LoginViewController: UIViewController, TransitionDelegate, Storyboarded {

    private var passwordFieldDelegate : BasicTextFieldDelegate!
    
    private var context: NSManagedObjectContext?
    
    weak var loginDelegate : LoginDelegate?
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
        
        loginDelegate?.onLogin(session: session)
    }
    
    func onCreateLogin() {
        guard let username = userNameField.text,
            let password = passwordField.text,
            let session = sessionManager.createSessionForNew(username: username, password: password ) else {
                onLoginError(errorTitle: "Create Login Failed", errorMessage: "Please try again.")
                return;
        }
    
        loginDelegate?.onLogin(session: session)
    }
    
//    private func createAndSeedContext(session: Session) {
//
//        context = createMainContext(session: session)
//
//        let dataService = DataService(context: context!)
//        dataService.seedStandardRecordTemplates()
//    }
    
    private func onLoginError(errorTitle: String, errorMessage: String) {
        passwordField.text=""
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        passwordTextDelegate = BasicTextFieldDelegate(transition: self)
        userNameField.delegate = userNameTextDelegate
        passwordField.delegate = passwordTextDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    @objc func keyboardWillShow(notification: NSNotification) {
         if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
             if self.view.frame.origin.y == 0 {
                 self.view.frame.origin.y -= keyboardSize.height/2
             }
         }
     }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let current = sessionManager.getCurrentSession() {
            loginDelegate?.onLogin(session: current)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
