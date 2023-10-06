//
//  UserStore.swift
//  Grew
//
//  Created by 김종찬 on 10/6/23.
//

import Firebase
import Foundation

class UserStore: ObservableObject {
    
    // 싱글톤 패턴
    static let shared = UserStore()
    
    @Published var user: User?
    
    init() {
        user = User(id: "", nickName: "", email: "", gender: .female, dob: "", userImageURLString: "", introduce: "", searchHistory: [])
    }
    
    // Firebase에 있는 유저정보 불러오기
    func loadUserData(userId: String) {
        let userRef = Firestore.firestore().collection("users").document(userId)
        userRef.getDocument { snapshot, error in
            if let snapshot = snapshot, snapshot.exists {
                let userData = snapshot.data()
                let nickName = userData?["nickName"] as? String ?? ""
                let email = userData?["email"] as? String ?? ""
                let dbgender = userData?["gender"] as? String ?? ""
                let gender = Gender(rawValue: dbgender) ?? .female
                let dob = userData?["dob"] as? String ?? ""
                let searchHistory = userData?["searchHistory"] as? [String] ?? []
                
                self.user = User(nickName: nickName, email: email, gender: gender, dob: dob, searchHistory: searchHistory)
            }
        }
    }
    
    func updateSearchHistory() {
        
    }
}
