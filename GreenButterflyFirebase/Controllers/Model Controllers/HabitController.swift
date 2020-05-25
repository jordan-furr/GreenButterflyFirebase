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
        Habit(title: "Refill Waterbottle", iconUID: "bottle", co2Value: 0.083, identifier: 0, source: "https://sciencing.com/carbon-footprint-plastic-bottle-12307187.html", fact: "Globally, humans now purchase 1 million single-use waterbottles a minute."),
        Habit(title: "Meatless Day", iconUID: "vegetarian", co2Value: 2.495, identifier: 1, source: "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2535638/", fact: "One 1/4 lb. of beef requires 425 gallons of water to produce."),
        Habit(title: "Laundry w/ cold water", iconUID: "machine", co2Value: 0.714, identifier: 2, source: "https://www.coldwatersaves.org/", fact: "Water heating can account for up to 90 percent of the total energy use in a hot water wash cycle")
    ]
 
    var enabledHabits: [Habit] = []
    var enabledCounts: [Int] = []
    var disabledHabits: [Habit] = []
    

    
    func fetchUserHabits(){
        guard let user = UserController.shared.currentUser else {return}
        enabledHabits = []
        disabledHabits = []
        enabledCounts = []
        
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
    
    func incrementHabitCounter(habit: Habit) -> Int{
        guard let user = UserController.shared.currentUser else {return 0}
        
        user.counts[habit.identifier] = user.counts[habit.identifier] + 1
        let data = ["counts" : user.counts]
        UserController.shared.updateUserData(userID: user.id, data: data)
        fetchUserHabits()
        return user.counts[habit.identifier]
    }
    
    func decrementHabitCounter(habit: Habit) -> Int{
        guard let user = UserController.shared.currentUser else {return 0}
        
        user.counts[habit.identifier] = user.counts[habit.identifier] - 1
        let data = ["counts" : user.counts]
        UserController.shared.updateUserData(userID: user.id, data: data)
        fetchUserHabits()
        return user.counts[habit.identifier]
    }
    
    func getUsertotalCO2() -> Double {
        guard let user = UserController.shared.currentUser else {return 0}
        var total: Double =  0
        for habit in defaultHabits {
            let habitTotal = habit.co2Value * Double(user.counts[habit.identifier])
            total = total + habitTotal
        }
        return total
    }
}
