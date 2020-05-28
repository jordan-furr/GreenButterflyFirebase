//
//  UserController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import CodableFirebase
import FirebaseAuth

struct UserKeys {
    static let emailKey = "email"
    static let idKey = "id"
    static let enabledKey = "enabled"
    static let countsKey = "counts"
}

class UserController {
    
    static let shared = UserController()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    lazy var storageRef = storage.reference()
    let usersRef : CollectionReference = Firestore.firestore().collection("users")
    
    var currentUser: User?
    
    
    func updateUserInfo(email: String, id: String, enabled: [Bool], counts: [Int], completion: @escaping (Result<User?, UserError>) -> Void) {
        let userDoc = usersRef.document(id)
        let data = [
            "\(UserKeys.emailKey)" : "\(email)",
            "\(UserKeys.idKey)" : "\(id)",
            "\(UserKeys.enabledKey)" : enabled,
            "\(UserKeys.countsKey)" : counts
            ] as [String : Any]
        userDoc.setData(data, merge: true) { (error) in
            if let error = error {
                return completion(.failure(.firebaseError(error)))
            } else {
                let updatedUser = User(email: email, id: id, enabled: enabled, counts: counts)
                self.currentUser = updatedUser
                return completion(.success(updatedUser))
            }
        }
    }
    
    
    func updatedUser() {
        self.fetchCurrentUser { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let user):
                print("Successfully updated user")
                self.currentUser = user
            }
        }
    }
    
    func fetchCurrentUser(completion: @escaping (Result<User?, UserError>) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            print("no current user")
            return completion(.failure(.noUserFound)) }
        let userDoc = usersRef.document(currentUserId)
        userDoc.getDocument { (snapshot, error) in
            if snapshot != nil {
                guard let snapshot = snapshot else { return completion(.failure(.noUserFound)) }
                guard let data = snapshot.data() else { return completion(.failure(.couldNotUnwrapUser)) }
                print(currentUserId)
                let user = try! FirestoreDecoder().decode(User.self, from: data)
                self.currentUser = user
                return completion(.success(user))
            } else {
                print("snapshot is nil")
                return completion(.failure(.noRecordFound))
            }
        }
    }
    
    func updateUserData(userID: String, data: [String: Any]){
        usersRef.document(userID).updateData(data) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.updatedUser()
            }
        }
    }
    
    func signoutCurrentUser() {
        try! Auth.auth().signOut()
        currentUser = nil
    }
    
    func sendResetPasswordLink(withEmail: String) {
        Auth.auth().sendPasswordReset(withEmail: withEmail) { (error) in
            if error == nil {
                print(error?.localizedDescription ?? "error"
                )
            } else {
                print("sent email to reset password")
            }
        }
    }
}
