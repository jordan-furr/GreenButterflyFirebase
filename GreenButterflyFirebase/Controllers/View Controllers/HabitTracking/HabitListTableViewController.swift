//
//  HabitListTableViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class HabitListTableViewController: UITableViewController {
    
    var habits: [Habit] = []
    
    //MARK: LIFECYCLE FUNCS
    override func viewWillAppear(_ animated: Bool) {
        HabitController.shared.fetchUserHabits()
        habits  = HabitController.shared.enabledHabits
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        //tableView.allowsSelection = false
        let image = UIImage(named: "title")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 80, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    //MARK: DATA SOURCE
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "habitCell", for: indexPath) as? HabitTableViewCell else {return UITableViewCell()}
        
        let habit = habits[indexPath.row]
        let count = HabitController.shared.enabledCounts[indexPath.row]
        cell.setHabitAndCount(habit: habit, count: count)
        cell.delegate = self
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    //MARK: HELPERS
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let habit = habits[indexPath.row]
            habits.remove(at: indexPath.row)
            HabitController.shared.toggleHabit(habit: habit)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let destinationVC = segue.destination as? HabitDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let habit = habits[indexPath.row]
                    destinationVC.habit = habit
                    destinationVC.delegate = self
                }
            }
        }
    }
}

extension HabitListTableViewController: HabitTableViewCellDelegate{
    func tappedButton(for cell: HabitTableViewCell) {
        guard let habit = cell.habit else {return}
        let newCount = HabitController.shared.incrementHabitCounter(habit: habit)
        cell.setHabitAndCount(habit: habit, count: newCount)
        print("tapped")
        HabitController.shared.fetchUserHabits()
    }
}

extension HabitListTableViewController: ModalDismissed {
    func modaldismissed() {
        tableView.reloadData()
        print("working")
    }
}
