//
//  UserViewModel.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/11.
//

import Firebase
import FirebaseStorage
import UIKit

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    
    private var db = Firestore.firestore()
    
    init() {
        guard let currentUserId = UserDefaults.standard.string(forKey: "userId") else {
            return
        }
        self.fetchUser(userId: currentUserId)
    }
    
    func fetchUser(userId: String) {
        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let result = Result {
                    try document.data(as: User.self)
                }
                switch result {
                case . success(let user):
                    self.currentUser = user
                case .failure(let error):
                    print("Error decoding user: \(error)")
                }
            }
        }
    }
    
    func updateUser(user: User) {
        if let userId = currentUser?.id {
            do {
                try db.collection("users").document(userId).setData(from: user)
            } catch let error {
                print("Error updating user: \(error)")
            }
        }
    }
}
