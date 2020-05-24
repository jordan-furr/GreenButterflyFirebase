//
//  HabitDetailViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

protocol ModalDismissed: class {
    func modaldismissed()
}
class HabitDetailViewController: UIViewController {

    //MARK: PROPERTIES
    var habit: Habit?
    weak var delegate: ModalDismissed?
    
    //MARK: IB OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var totalKWHLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var kwhLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        decrementButton.addCornerRadius()
        sourceButton.addCornerRadius()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.modaldismissed()
    }

    func setUpViews(){
        guard let habit = habit, let user = UserController.shared.currentUser else {return}
         let counts = user.counts[habit.identifier]
        countLabel.text = "\(counts)"
        titleLabel.text = habit.title
        
        factLabel.text = habit.fact
       
        kwhLabel.text = "CO2 saved per action:   \(habit.co2Value)kg"
        let totalCO2 = Double(round((Double(counts) * habit.co2Value) * 100) / 100)
        totalKWHLabel.text = "Total CO2 saved by actions:   \(totalCO2)kg"
        iconImageView.image = UIImage(named: habit.iconUID)
    }
    
    //MARK: IB ACTIONS

    @IBAction func decrementTapped(_ sender: Any) {
        guard let habit = habit else {return}
        let newCount = HabitController.shared.decrementHabitCounter(habit: habit)
        countLabel.text = "\(newCount)"
        print("tapped")
        HabitController.shared.fetchUserHabits()
    }
    
    
    @IBAction func sourceTapped(_ sender: Any) {
        guard let habit = habit else {return}
        if let url = URL(string: habit.source){
            UIApplication.shared.open(url)
        }
    }
}
