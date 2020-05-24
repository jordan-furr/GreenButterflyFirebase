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
    var kwhValue: Double
    var identifier: Int
    var source: String
    var fact: String
    
    init(title: String, iconUID: String, kwhValue: Double, identifier: Int, source: String, fact: String){
        self.title = title
        self.iconUID = iconUID
        self.kwhValue = kwhValue
        self.identifier = identifier
        self.source = source
        self.fact = fact
    }
}
