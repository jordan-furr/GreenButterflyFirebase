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
        Habit(title: "Refill Waterbottle", iconUID: "starADD", kwhValue: 2.19444, identifier: 0, source: "http://www.container-recycling.org/assets/pdfs/2009-BottledWaterEnergy.pdf", fact: "Globally, humans now purchase 1 million single-use waterbottles a minute."),
        Habit(title: "Meatless Day", iconUID: "starADD", kwhValue: 9.881, identifier: 1, source: "https://www.meatlessmonday.com/research/environment/", fact: "One 1/4 lb. of beef requires 425 gallons of water to produce."),
        Habit(title: "Laundry w/ cold water", iconUID: "starADD", kwhValue: 1, identifier: 2, source: "coldwatersaves.org", fact: "Water heating can account for up to 90 percent of the total energy use in a hot water wash cycle")
    ]
    
    let kwhCost = 12.85
    
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
        guard let user = UserController.shared.currentUser,
            let index = defaultHabits.firstIndex(of: habit) else {return 0}
        
        user.counts[index] = user.counts[index] + 1
        let data = ["counts" : user.counts]
        UserController.shared.updateUserData(userID: user.id, data: data)
        fetchUserHabits()
        return user.counts[index]
    }
}
