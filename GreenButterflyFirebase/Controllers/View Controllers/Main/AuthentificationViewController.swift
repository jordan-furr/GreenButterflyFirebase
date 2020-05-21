//
//  AuthentificationViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class AuthentificationViewController: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    
    //MARK: PROPERTIES
    var loginMode = false
    
    override func viewDidLoad() {
          super.viewDidLoad()
          setupViews()
      }
    
    //MARK: IB ACTIONS
    @IBAction func actionTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmTextField.text else {return}
        
        if loginMode {
            //LOGGING IN
            if email != "" {
                FirebaseController.shared.login(email: email, password: password) { (success) in
                    if success {
                        self.performSegue(withIdentifier: "loggedin", sender: self)
                        print("logging user in")
                    } else {
                        print("error logging in")
                    }
                }
            }
        } else {
            //SIGNING UP
            if email != "" && password == confirm && password.count >= 5 {
                FirebaseController.shared.signup(email: email, password: password) { (success, error) in
                    if success {
                        self.performSegue(withIdentifier: "onboarding", sender: self)
                        print("signing user up")
                    } else {
                        print("error signing up")
                    }
                }
            }
        }
    }
    
    
    @IBAction func signupTapped(_ sender: Any) {
        loginMode = false
        confirmTextField.isHidden = false
        actionButton.setTitle("SIGN UP", for: .normal)
    }
    @IBAction func loginTapped(_ sender: Any) {
        loginMode = true
        confirmTextField.isHidden = true
        actionButton.setTitle("LOGIN", for: .normal)
    }
    
    //MARK: HELPERS
    func setupViews(){
        ButterflyGradient.setUpButterflyView(view: view)
        actionButton.addCornerRadius()
        loginTapped(self)
        emailTextField.addDoneButtonOnKeyboard()
        passwordTextField.addDoneButtonOnKeyboard()
        confirmTextField.addDoneButtonOnKeyboard()
    }
}
