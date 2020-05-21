//
//  LaunchViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import FirebaseAuth

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ButterflyGradient.setUpButterflyView(view: view)
        
        DispatchQueue.main.async {
            if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: "userFound", sender: self)
            } else {
                self.performSegue(withIdentifier: "noUser", sender: self)
            }
        }
        
        // if Auth.auth().currentUser != nil {
        //            UserController.shared.fetchCurrentUser { (result) in
        //                switch result {
        //                case .failure(let error):
        //                    print(error.localizedDescription)
        //                    self.performSegue(withIdentifier: "noUser", sender: self)
        //                case.success(let user):
        //                    print("Successfully fetched user")
        //                    UserController.shared.currentUser = user
        //                    self.performSegue(withIdentifier: "userFound", sender: self)
        //                }
        //            }
        //        } else{
        //            self.performSegue(withIdentifier: "noUser", sender: self)
        //       }
    }
    
    //MARK: HELPERS
}
