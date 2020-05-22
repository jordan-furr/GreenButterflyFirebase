//
//  AddHabitsTableViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class AddHabitsTableViewController: UITableViewController {
    
    var habits: [Habit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HabitController.shared.fetchUserHabits()
        habits = HabitController.shared.disabledHabits
        tableView.reloadData()
        tableView.allowsMultipleSelection = true
    }
    
    //MARK: IB FUNCTIONS
    @IBAction func doneTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        parent?.reloadInputViews()
    }
    
    // MARK: - DATA SOURCE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newHabit", for: indexPath)
        cell.textLabel?.text = HabitController.shared.disabledHabits[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        let habit = habits[indexPath.row]
        HabitController.shared.toggleHabit(habit: habit)
        print("\(habit.title) enabled)")
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        let habit = habits[indexPath.row]
        HabitController.shared.toggleHabit(habit: habit)
        print("\(habit.title) disabled)")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
