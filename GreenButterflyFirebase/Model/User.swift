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
        case email, id, enabled, counts
    }
    
    var email: String
    var id: String
    var enabled: [Bool]
    var counts: [Int]
    
    init(email: String, id: String, enabled: [Bool], counts: [Int]) {
        self.email = email
        self.id = id
        self.enabled = enabled
        self.counts = counts
    }
}
