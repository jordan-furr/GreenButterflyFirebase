//
//  FirebaseController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore


class FirebaseController {
    
    static let shared = FirebaseController()
    
    let db = Firestore.firestore()
    
   func signup(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
                completion(false, error)
            }
            guard let user = user else {return}
            let currentUser = Auth.auth().currentUser;
            print(" User Created \(user)")
            let values = ["email": email, "uid": currentUser?.uid]
            self.db.collection("users").document(currentUser!.uid).setData(values as [String : Any])
            completion(true, nil)
            print("Saved user to database")
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
                completion(false)
                return
            }
            completion(true)
            return
        }
    }
}
