//
//  HabitController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

class HabitController {
    
    static let shared = HabitController()
    
    var defaultHabits: [Habit] = [
        Habit(title: "Refill Waterbottle", iconUID: "", energyValue: 10),
        Habit(title: "Vegetarian Day", iconUID: "", energyValue: 8),
        Habit(title: "Washed laundry with cold water", iconUID: "", energyValue: 4)
    ]
    
    var enabledHabits: [Habit] = []
    var enabledCounts: [Int] = []
    var disabledHabits: [Habit] = []
    

    
    func fetchUserHabits(){
        guard let user = UserController.shared.currentUser else {return}
        enabledHabits = []
        disabledHabits = []
        
        let allHabits = defaultHabits
        for i in 0..<allHabits.count {
            if user.enabled[i]{
                enabledHabits.append(allHabits[i])
                enabledCounts.append(user.counts[i])
            } else {
                disabledHabits.append(allHabits[i])
            }
        }
    }
    
    func toggleHabit(habit: Habit){
        guard let user = UserController.shared.currentUser,
            let index = defaultHabits.firstIndex(of: habit) else {return}
        
        user.enabled[index] = !user.enabled[index]
        let data = ["enabled" : user.enabled]
        UserController.shared.updateUserData(userID: user.id, data: data)
        fetchUserHabits()
    }
    
    func incrementHabitCounter(habit: Habit){
        guard let user = UserController.shared.currentUser,
            let index = defaultHabits.firstIndex(of: habit) else {return}
        
        user.counts[index] = user.counts[index] + 1
        let data = ["counts" : user.counts]
        UserController.shared.updateUserData(userID: user.id, data: data)
        fetchUserHabits()
    }
}
