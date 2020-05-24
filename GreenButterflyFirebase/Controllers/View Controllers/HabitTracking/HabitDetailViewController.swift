//
//  HabitDetailViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class HabitDetailViewController: UIViewController {

    //MARK: PROPERTIES
    var habit: Habit?
    
    //MARK: IB OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var totalKWHLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var sourceLabel: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var kwhLabel: UILabel!
    @IBOutlet weak var sourceTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        sourceTextView.isEditable = false
        tableview.delegate = self
        tableview.dataSource = self
    }
    

    func setUpViews(){
        guard let habit = habit, let user = UserController.shared.currentUser else {return}
        titleLabel.text = habit.title
        factLabel.text = habit.fact
        let counts = user.counts[habit.identifier]
        countLabel.text = "\(counts)"
        kwhLabel.text = "\(habit.kwhValue)"
        let totalKWH = Double(counts) * habit.kwhValue
        totalKWHLabel.text = "Total kwH saved: \(totalKWH)"
        totalCostLabel.text = "Total dollars saved: \(HabitController.shared.kwhCost * totalKWH)"
        sourceTextView.text = habit.source
    }
    
    //MARK: IB ACTIONS
    @IBAction func resetTapped(_ sender: Any) {
        countLabel.text = "0"
        totalKWHLabel.text = "0"
        totalCostLabel.text = "0"
    }
    

}
extension HabitDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let habit = habit else {return 0}
        return UserController.shared.currentUser!.counts[habit.identifier]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countCell", for: indexPath)
        cell.textLabel?.text = "🦋"
        return cell
    }
}
