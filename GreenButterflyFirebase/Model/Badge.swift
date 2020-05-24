//
//  Badge.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/24/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

class Badge: NSObject {
    
    var title: String
    var badgeUID: String
    
    init(title: String, badgeUID: String){
        self.title = title
        self.badgeUID = badgeUID
    }
}
