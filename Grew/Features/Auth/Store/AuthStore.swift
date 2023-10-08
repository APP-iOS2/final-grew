//
//  AuthStore.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//
// 다른 페이지에서 어떤식으로 데이터를 사용할 것인가
// 자동 로그인을 어떻게 잘 활용할 것인가

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
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var nickName: String = ""
    @Published var gender: Gender = .female
    @Published var dob: String = ""
    @Published var searchHistory: [String] = []
    
    let userStore: UserStore = UserStore()
    
    init() {
        currentUser = Auth.auth().currentUser
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
    func emailAuthSignUp() async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            await uploadUserData(uid: result.user.uid, email: email, nickName: nickName, gender: gender, dob: dob)
            resetUserData()
        } catch {
            print("email SignUp error: \(error.localizedDescription)")
        }
    }
    
    // 로그인
    @MainActor
    func emailAuthSignIn() async throws {
        do {
            let result =  try await Auth.auth().signIn(withEmail: email, password: password)
            self.currentUser = result.user
            self.signState = .email
            print("email Signin success")
            print(currentUser?.uid)
            userStore.loadUserData(userId: currentUser?.uid ?? "")
        } catch {
            print("email SignIn error: \(error.localizedDescription)")
        }
    }
    
    // 로그아웃
    func emailAuthSignOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.signState = .signOut
            resetUserData()
        } catch {
            print("email SignOut error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Firebase 정보 관련
    // 유저정보 Firebase에 업데이트
    @MainActor
    func uploadUserData(uid: String, email: String, nickName: String, gender: Gender, dob: String) async {
        let user = User(id: uid, nickName: nickName, email: email, gender: gender, dob: dob, searchHistory: [])
        
        let userDict = [
            "id": user.id,
            "nickName": user.nickName,
            "email": user.email,
            "gender": user.gender.rawValue,
            "dob": user.dob,
            "searchHistory": user.searchHistory
        ] as [String: Any]
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(userDict)
    }
    
    // 초기화
    func resetUserData() {
        email = ""
        password = ""
        nickName = ""
        dob = ""
        searchHistory = []
    }
}
