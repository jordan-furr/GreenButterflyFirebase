//
//  LightNavBarViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 6/4/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class LightNavBarViewController: UINavigationController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
           setNeedsStatusBarAppearanceUpdate()
       }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
     return .lightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
