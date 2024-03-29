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
        let image = UIImage(named: "title")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 80, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    // MARK: - DATA SOURCE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newHabit", for: indexPath) as? NewHabitTableViewCell else {return UITableViewCell()}
        let habit = habits[indexPath.row]
        cell.setHabit(habit: habit)
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.tintColor = .white
        cell.accessoryType = .none
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
        cell?.accessoryType = .none
        let habit = habits[indexPath.row]
        HabitController.shared.toggleHabit(habit: habit)
        print("\(habit.title) disabled)")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
}
