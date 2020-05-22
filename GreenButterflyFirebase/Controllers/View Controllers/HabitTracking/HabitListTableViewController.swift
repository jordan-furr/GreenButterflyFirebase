//
//  HabitListTableViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class HabitListTableViewController: UITableViewController {

    //MARK PROPERTIES
    var enabledHabits: [Habit] = []
    var disabledHabits: [Habit] = []
    var enabledCounts: [Int] = []
    
    
    //MARK: LIFECYCLE FUNCS
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserHabits()
        tableView.reloadData()
    }

    
    //MARK: IB FUNCTIONS
    
   
    //MARK: DATA SOURCE
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           enabledHabits.count
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitCell", for: indexPath)
        let habit = enabledHabits[indexPath.row]
        let count = enabledCounts[indexPath.row]
        cell.textLabel?.text = habit.title
        cell.detailTextLabel?.text = "\(count)"
        return cell
    }

    //MARK: HELPERS
    func loadUserHabits(){
        guard let user = UserController.shared.currentUser else {return}
        let allHabits = HabitController.shared.defaultHabits
        
        for i in 0..<allHabits.count {
            if user.enabled[i]{
                enabledHabits.append(allHabits[i])
                enabledCounts.append(user.counts[i])
            } else {
                disabledHabits.append(allHabits[i])
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addHabits"{
            if let desitnationVC = segue.destination as? AddHabitsTableViewController {
        //        desitnationVC.disabledHabits = disabledHabits
            }
        }
    }
}
