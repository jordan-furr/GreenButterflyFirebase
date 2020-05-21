//
//  LaunchViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = #imageLiteral(resourceName: "butterfly")
        let mask = CALayer()
        mask.contents = image.cgImage
        mask.frame.size = image.size
        let gradient = CAGradientLayer()
        gradient.frame.size = image.size
        
        gradient.colors = [
            UIColor(red: 0.04, green: 0.13, blue: 0.59, alpha: 1).cgColor,
            UIColor(red: 0.08, green: 1, blue: 0.3, alpha: 1).cgColor,
            UIColor(red: 0.85, green: 0.25, blue: 0.25, alpha: 1).cgColor
        ]
        gradient.mask = mask
        gradient.frame.origin = CGPoint(x: (view.center.x - 80), y: 70)
        view.layer.addSublayer(gradient)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "noUser", sender: self)
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
}
