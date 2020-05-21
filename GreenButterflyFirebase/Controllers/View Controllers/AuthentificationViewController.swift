//
//  AuthentificationViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class AuthentificationViewController: UIViewController {

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
               view.layer.addSublayer(gradient)
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
