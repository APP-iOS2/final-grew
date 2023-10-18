//
//  UserViewModel.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/11.
//

import UIKit
import Firebase
import FirebaseStorage

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

extension UserViewModel {
    func uploadProfileImage(_ image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(false)
            return
        }
        
        guard let userId = currentUser?.id else {
            completion(false)
            return
        }
        
        let storageRef = Storage.storage().reference().child("userImageURLString/\(userId).jpg")
        
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error)")
                completion(false)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Error download URL: \(error?.localizedDescription ?? "No error description.")")
                    completion(false)
                    return
                }
                
                self.currentUser?.userImageURLString = downloadURL.absoluteString
            }
        }
    }
    
    func fetchProfileImage(userId: String, completion: @escaping (URL?) -> Void) {
        let storageRef = Storage.storage().reference().child("userImageURLString/\(userId).jpg")
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error fetching profile image: \(error)")
                completion(nil)
            } else {
                completion(url)
            }
        }
    }
}
