//
//  AuthStore.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import FBSDKLoginKit
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class AuthStore: ObservableObject {
    
    @Published var currentUser: FirebaseAuth.User?
    @Published var signState: SignState = .signOut
    
    static let shared = AuthStore()
    
    private init() {
        self.currentUser = Auth.auth().currentUser
    }
    
    enum SignState {
        case signOut
        case email
//        case facebook
//        case kakao
    }
    
    // MARK: - email 로그인
    // 회원가입
    @MainActor
    func emailAuthSignUp(withEmail email: String, password: String, nickName: String, gender: String, dob: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            await uploadUserData(uid: result.user.uid, email: email, nickName: nickName, gender: gender, dob: dob)
        } catch {
            print("email SignUp error: \(error.localizedDescription)")
        }
    }
    
    // 로그인
    @MainActor
    func emailAuthSignIn(withEmail email: String, password: String) async throws {
        do {
            let result =  try await Auth.auth().signIn(withEmail: email, password: password)
            self.currentUser = result.user
            self.signState = .email
            print("email Signin success")
            try await UserStore.shared.loadUserData()
        } catch {
            print("email SignIn error: \(error.localizedDescription)")
        }
    }
    
    // 로그아웃
    func emailAuthSignOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            print("Signout")
            self.signState = .signOut
        } catch {
            print("email SignOut error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Firebase 정보 관련
    // 유저정보 Firebase에 업데이트
    @MainActor
    func uploadUserData(uid: String, email: String, nickName: String, gender: String, dob: String) async {
        let user = User(id: uid, nickName: nickName, email: email, gender: gender, dob: dob, searchHistory: [])
        
        let userDict = [
            "id": user.id,
            "nickName": user.nickName,
            "email": user.email,
            "gender": user.gender,
            "dob": user.dob,
            "searchHistory": user.searchHistory
        ] as [String: Any]
        
        try? await Firestore.firestore().collection("users").document(user.id ?? "").setData(userDict)
    }
    
}
