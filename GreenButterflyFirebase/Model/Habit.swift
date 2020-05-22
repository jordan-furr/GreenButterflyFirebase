//
//  Habit.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//
import UIKit
import Foundation

class Habit: NSObject {
    
    var title: String
    var iconUID: String
    var energyValue: Int
    
    init(title: String, iconUID: String, energyValue: Int){
        self.title = title
        self.iconUID = iconUID
        self.energyValue = energyValue
    }
}
