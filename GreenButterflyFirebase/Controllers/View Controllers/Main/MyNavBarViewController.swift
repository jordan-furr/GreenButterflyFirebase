//
//  MyNavBarViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class MyNavBarViewController: UINavigationController {

    override func viewWillAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "next", sender: self)
    }
    var habits: [Habit]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? HabitListTableViewController{
            guard let habits = habits else {return}
            destinationVC.habits = habits
            print("nav bar segue")
        }
    }

}
