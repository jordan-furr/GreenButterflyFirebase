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
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var kwhLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var sourceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        tableview.delegate = self
        tableview.dataSource = self
        decrementButton.addCornerRadius()
        sourceButton.addCornerRadius()
    }
    

    func setUpViews(){
        guard let habit = habit, let user = UserController.shared.currentUser else {return}
         let counts = user.counts[habit.identifier]
        countLabel.text = "\(counts)"
        titleLabel.text = habit.title
        
        factLabel.text = habit.fact
       
        kwhLabel.text = "kwh saved per action: \(habit.kwhValue)"
        let totalKWH = Double(round((Double(counts) * habit.kwhValue) * 1000) / 1000)
        totalKWHLabel.text = "kwH saved by actions: \(totalKWH)"
    }
    
    //MARK: IB ACTIONS
    @IBAction func resetTapped(_ sender: Any) {
        countLabel.text = "0"
        totalKWHLabel.text = "0"
    }
    
    @IBAction func sourceTapped(_ sender: Any) {
        guard let habit = habit else {return}
        if let url = URL(string: habit.source){
            UIApplication.shared.open(url)
        }
    }
    
    
    

}
extension HabitDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let habit = habit else {return 0}
        return UserController.shared.currentUser!.counts[habit.identifier]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countCell", for: indexPath)
        cell.textLabel?.text = "🤍"
        return cell
    }
}
