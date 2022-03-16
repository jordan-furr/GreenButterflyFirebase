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
    @IBOutlet weak var confirmStack: UIStackView!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var forgotbutton: UIButton!
    
    
    //MARK: PROPERTIES
    var loginMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: IB ACTIONS
    @IBAction func actionTapped(_ sender: Any) {
        
        
        
        
        self.view.endEditing(true)
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmTextField.text else {return}
        
        if loginMode {
            //LOGGING IN
            if email != "" {
                FirebaseController.shared.login(email: email, password: password) { (success) in
                    if success {
                        self.view.isHidden = true
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                        UserController.shared.fetchCurrentUser { (result) in
                            switch result {
                            case .failure(let error):
                                print("error fetching user", error)
                            case .success(let user):
                                print("user fetched successfully")
                                UserController.shared.currentUser = user
                                HabitController.shared.fetchUserHabits()
                                self.performSegue(withIdentifier: "loggedin", sender: self)
                            }
                        }
                        print("logging user in")
                    } else {
                        print("error logging in")
                        self.presentLoginAlertView()
                        self.setupViews()
                    }
                }
            } else {
                self.presentEmptyAlertView()
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
                        self.view.isHidden = true
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                        //   ButterflyGradient.setUpButterflyView(view: self.view)
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
                        self.presentSignupAlertView()
                        self.setupViews()
                    }
                }
            }
        }
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        loginMode = false
        confirmStack.isHidden = false
        forgotbutton.isHidden = true
        loginButton.setTitleColor(.darkGreen, for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        actionButton.setTitle("SIGN UP", for: .normal)
    }
    @IBAction func loginTapped(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        loginMode = true
        forgotbutton.isHidden = false
        confirmStack.isHidden = true
        loginButton.setTitleColor(.white, for: .normal)
        signupButton.setTitleColor(.darkGreen, for: .normal)
        actionButton.setTitle("LOGIN", for: .normal)
    }
    
    @IBAction func backgroundtapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    //MARK: HELPERS
    func setupViews(){
        loginTapped(self)
        actionButton.addCornerRadius()
        emailTextField.addDoneButtonOnKeyboard()
        passwordTextField.addDoneButtonOnKeyboard()
        confirmTextField.addDoneButtonOnKeyboard()
        emailTextField.autocorrectionType = .yes
        passwordTextField.autocorrectionType = .no
        confirmTextField.autocorrectionType = .no
        setNeedsStatusBarAppearanceUpdate()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let barVC = segue.destination as? UITabBarController {
            let navBar = barVC.viewControllers![0] as! UINavigationController
            let destinationVC = navBar.topViewController as! HabitListTableViewController
            destinationVC.habits = HabitController.shared.enabledHabits
            print("authentification segue")
        }
    }
    
    @objc fileprivate func animateButton(sender:UIButton){
        self.animateView(sender)
    }
    
    fileprivate func animateView(_ viewToAnimate:UIView){
        UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
            
        }) { (_) in
            //return from animation
            UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    
    
    //ALERTS
    func presentSignupAlertView() {
        let alertController = UIAlertController(title: "Error", message: "Couldn't create account", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    func presentEmptyAlertView() {
        let alertController = UIAlertController(title: "Missing Information", message: "Please enter login credentials", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func presentLoginAlertView() {
        let alertController = UIAlertController(title: "Error", message: "Email/password is incorrect", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
