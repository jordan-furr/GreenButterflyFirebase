//
//  Habit.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//
import UIKit
import Foundation

class Habit: NSObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case title, counter, enabled, iconUID
    }
    
    var title: String
    var counter: Int
    var enabled: Bool
    var iconUID: String
    
    init(title: String, counter: Int, enabled: Bool, iconUID: String){
        self.title = title
        self.counter = counter
        self.enabled = enabled
        self.iconUID = iconUID
    }
}
