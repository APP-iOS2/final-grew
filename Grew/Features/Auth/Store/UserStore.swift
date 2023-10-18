//
//  UserStore.swift
//  Grew
//
//  Created by 김종찬 on 10/6/23.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

class UserStore: ObservableObject {
    
    // 싱글톤 패턴
    static let shared = UserStore()
    private static let db = Firestore.firestore()
    
    @Published var currentUser: User?
    
    init() {
        Task {
            try await loadUserData()
        }
    }
    
    // Firebase에 있는 유저정보 불러오기
    func loadUserData() async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let userRef = Firestore.firestore().collection("users").document(userId)
//        userRef.getDocument { snapshot, error in
//            if let snapshot = snapshot, snapshot.exists {
//                let userData = snapshot.data()
//                let nickName = userData?["nickName"] as? String ?? ""
//                let email = userData?["email"] as? String ?? ""
//                let dbgender = userData?["gender"] as? String ?? ""
//                let gender = Gender(rawValue: dbgender) ?? .female
//                let dob = userData?["dob"] as? String ?? ""
//                let searchHistory = userData?["searchHistory"] as? [String] ?? []
//                
//                self.currentUser = User(nickName: nickName, email: email, gender: gender, dob: dob, searchHistory: searchHistory)
//            }
//        }
        let snapshot = try await userRef.getDocument()
        self.currentUser = try snapshot.data(as: User.self)
        
//        print(self.currentUser!)
    }
    
    func updateSearchHistory() {
        
    }
    
    static func requestAndReturnUsers(userID: [String]) async -> [User]? {
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
}
