//
//  AuthentificationViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import FirebaseAuth

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
                        let alertController = UIAlertController(title: "Error", message: "Login credentials incorrect", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        } else {
            //SIGNING UP
            
            if password != confirm {
                let alertController = UIAlertController(title: "Passwords do not match", message: "Please re-type password", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            if password.count < 6 {
                let alertController = UIAlertController(title: "Password is too short", message: "Password must be at least 6 characters", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            if email != "" && password == confirm && password.count >= 6 {
                FirebaseController.shared.signup(email: email, password: password) { (success, error) in
                    if success {
                        print("signing user up")
                        
                        var emptyEnabled: [Bool] = []
                        var emptyCounts: [Int] = []
                        
                        for _ in HabitController.shared.defaultHabits {
                            emptyEnabled.append(false)
                            emptyCounts.append(0)
                        }
                        UserController.shared.updateUserInfo(email: email, id: Auth.auth().currentUser!.uid, enabled: emptyEnabled, counts: emptyCounts) { (result) in
                            if let error = error {
                                print(error)
                            } else {
                                print("user updated with empty habits")
                                UserController.shared.updatedUser()
                                self.performSegue(withIdentifier: "loggedin", sender: self)
                            }
                        }
                    } else {
                        print("error signing up")
                        let alertController = UIAlertController(title: "Error signing up", message: "Please try again", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
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
    
    @IBAction func backgroundtapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    //MARK: HELPERS
    func setupViews(){
        actionButton.addCornerRadius()
        loginTapped(self)
        emailTextField.addDoneButtonOnKeyboard()
        passwordTextField.addDoneButtonOnKeyboard()
        confirmTextField.addDoneButtonOnKeyboard()
    }
}
