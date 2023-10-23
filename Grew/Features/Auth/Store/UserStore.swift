//
//  UserStore.swift
//  Grew
//
//  Created by 김종찬 on 10/6/23.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Foundation

class UserStore: ObservableObject {
    
    // 싱글톤 패턴
    static let shared = UserStore()
    private static let db = Firestore.firestore()
    
    @Published var currentUser: User?
    
    public init() {
        Task {
            try await loadUserData()
        }
    }
    
    @MainActor
    func fetchCurrentUser(_ user: User) {
        self.currentUser = user
        print(self.currentUser!)
    }
    
    // Firebase에 있는 유저정보 불러오기
    func loadUserData() async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let userRef = Firestore.firestore().collection("users").document(userId)
        let snapshot = try await userRef.getDocument()
        let currentUser = try snapshot.data(as: User.self)
        await fetchCurrentUser(currentUser)
    }
    
    // 검색기록 user 데이터에 업로드
    func updateSearchHistory(searchHistory: [String]) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let userRef = Firestore.firestore().collection("users").document(userId)
        userRef.updateData(["searchHistory": searchHistory])
        Task {
            try await loadUserData()
        }
    }
    
    static func requestAndReturnUsers(userID: [String]) async -> [User]? {
//        if userID.isEmpty { return nil }
        var newUser: [User] = []
        for user in userID {
            let doc = db.collection("users").document(user)
            do {
                let user = try await doc.getDocument(as: User.self)
                newUser.append(user)
            } catch {
                print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
                return nil
            }
        }
        return newUser
    }
    
    func updateUser(user: User) {
        if let userId = currentUser?.id {
            do {
                try UserStore.db.collection("users").document(userId).setData(from: user)
            } catch let error {
                print("Error updating user: \(error)")
            }
        }
    }
    
    func isCurrentUserProfile() -> Bool {
        return currentUser?.id == UserStore.shared.currentUser?.id
    }
    
    func checkFavorit(gid: String) -> Bool {
        let favoritGrew: [String] = UserStore.shared.currentUser?.favoritGrew ?? []
        // 유저안에 그루가 있으면 true
        if favoritGrew.contains(gid) {
            return true
        } else {
            // 유저안에 그루가 없으면 false
            return false
        }
    }
    
    func addFavorit(gid: String) -> Bool  {
        var flag: Bool = true
        var favoritGrew: [String] = UserStore.shared.currentUser?.favoritGrew ?? []
        
        if checkFavorit(gid: gid) {
            // 유저안에 그루가 있으면 true
            // 유저안에 그루를 삭제
            var index: Int = 0
            for grewID in favoritGrew {
                if grewID == gid {
                    favoritGrew.remove(at: index)
                    break
                }
                index += 1
            }
            flag = false
            
        } else {
            // 유저안에 그루가 없으면 false
            // 그루가 없어서 추가
            favoritGrew += [gid]
        }
        
        if let userID = currentUser?.id {
            let userRef = UserStore.db.collection("users").document(userID)
            userRef.updateData([
                "favoritGrew" : favoritGrew
            ]) { err in
                if let err = err {
                    print("\(err.localizedDescription)")
                } else { print("") }
            }
            Task {
                try await loadUserData()
            }
        }
        return flag
    }
    
    func findUser(id: String) async throws -> User? {
        let db = Firestore.firestore()
        let document = try await db.collection("users").document(id).getDocument()
        if document.exists {
            return try document.data(as: User.self)
        } else {
            return nil
        }
    }
}


extension UserStore {
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
