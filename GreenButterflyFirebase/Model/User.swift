//
//  User.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Foundation

class User: Codable {
    
    enum CodingKeys: String, CodingKey {
        case email, id, habits
    }
    
    var email: String
    var id: String
    var habits: [Habit]
    
    init(email: String, id: String, habits: [Habit]) {
        self.email = email
        self.id = id
        self.habits = habits
    }
}
