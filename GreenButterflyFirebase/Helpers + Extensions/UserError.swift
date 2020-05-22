//
//  UserError.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

enum UserError: LocalizedError {
    case firebaseError(Error)
    case noUserFound
    case couldNotUnwrapUser
    case noRecordFound
    case noUserLoggedIn
    case noUserForRecord
    
    var errorDescription: String {
        switch self {
        case .firebaseError(let error):
            return ("Firebase returned an error: \(error.localizedDescription)")
        case .noUserFound:
            return "No user was found"
        case .couldNotUnwrapUser:
            return "Could not unwrap the value."
        case .noRecordFound:
            return "No user record was found."
        case .noUserLoggedIn:
            return "No user logged in, please visit settings and check your user status"
        case .noUserForRecord:
            return "No user for this record can be found."
        }
    }
}
