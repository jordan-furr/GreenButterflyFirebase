//
//  ExtraViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ExtraViewController: UIViewController {

    
    //MARK: IB OUTLETS
    @IBOutlet weak var logoutbutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "titleSmall")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 80, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        logoutbutton.addCornerRadius()
    }
    
    @IBAction func logouttapped(_ sender: Any) {
           let alertController = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .alert)
           let defaultAction = UIAlertAction(title: "Go ahead", style: .default, handler: { action in
               
               UserController.shared.signoutCurrentUser()
               
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               guard let initial = storyboard.instantiateInitialViewController() else {return}
               self.present(initial, animated: true, completion: nil)
           })
           alertController.addAction(defaultAction)
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           alertController.addAction(cancelAction)
           present(alertController, animated: true, completion: nil)
       }
    
   
    

}
