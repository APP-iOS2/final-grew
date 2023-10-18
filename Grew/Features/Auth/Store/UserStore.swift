//
//  UserStore.swift
//  Grew
//
//  Created by 김종찬 on 10/6/23.
//

import Firebase
import FirebaseAuth
import Foundation

class UserStore: ObservableObject {
    
    // 싱글톤 패턴
    static let shared = UserStore()
    
    @Published var currentUser: User?
    
    init() {
        Task {
            try await loadUserData()
        }
    }
    
    // Firebase에 있는 유저정보 불러오기
    @MainActor
    func loadUserData() async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let userRef = Firestore.firestore().collection("users").document(userId)
        let snapshot = try await userRef.getDocument()
        self.currentUser = try snapshot.data(as: User.self)
        
    }
    
    // 검색기록 user 데이터에 업로드
    func updateSearchHistory(searchHistory: [String]) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let userRef = Firestore.firestore().collection("users").document(userId)
        userRef.updateData(["searchHistory": searchHistory])
    }
}
