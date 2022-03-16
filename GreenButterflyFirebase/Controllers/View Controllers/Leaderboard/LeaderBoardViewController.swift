//
//  LeaderBoardViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 3/16/22.
//  Copyright © 2022 Jordan Furr. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "titleSmall")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 80, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation


}
