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
}
