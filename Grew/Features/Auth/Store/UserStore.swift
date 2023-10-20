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
}

