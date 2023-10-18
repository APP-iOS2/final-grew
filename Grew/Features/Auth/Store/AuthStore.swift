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
        case signUp
        case signIn
    }
    
    
    // MARK: - email 로그인
    // 회원가입
    @MainActor
    func emailAuthSignUp(withEmail email: String, password: String, nickName: String, gender: String, dob: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            await uploadUserData(uid: result.user.uid, email: email, nickName: nickName, gender: gender, dob: dob)
            self.currentUser = result.user
            self.signState = .signIn
            try await UserStore.shared.loadUserData()
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
            self.signState = .signIn
            UserDefaults.standard.set("email", forKey: "SignType")
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
            UserStore.shared.currentUser = nil
            self.signState = .signOut
            UserDefaults.standard.removeObject(forKey: "SignType")
            print("Signout")
        } catch {
            print("email SignOut error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 카카오톡 로그인
    // 로그인
    func kakaoSignIn(completion: @escaping () -> Void) {
        // 카카오톡 앱 로그인 시도
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauth, error in
                if let error = error {
                    print("Kakao app signin error \(error.localizedDescription)")
                } else {
                    print("Kakao app signin success")
                    self.kakaoSignInLoad()
                    completion()
                }
            }
        }
        // 카카오톡 웹 로그인 시도
        else {
            UserApi.shared.loginWithKakaoAccount { oauth, error in
                if let error = error {
                    print("Kakao web signin error \(error.localizedDescription)")
                } else {
                    print("Kakao web signin success")
                    self.kakaoSignInLoad()
                    completion()
                }
            }
        }
    }
    
    // 카카오 로그인 유저 가입여부 확인
    func kakaoSignInLoad() {
        UserApi.shared.me { user, error in
            if let error = error {
                print("Kakao user data error \(error.localizedDescription)")
            } else {
                
                let userEmail = user?.kakaoAccount?.email
                
                UserDefaults.standard.set("kakao", forKey: "SignType")
                
                Firestore.firestore().collection("users").whereField("email", isEqualTo: (user?.kakaoAccount?.email)!).getDocuments { snapshot, error in
                    // 신규로 가입이 필요한 유저
                    if snapshot!.documents.isEmpty {
                        self.signState = .signUp
                    }
                    // 기존에 가입된 유저
                    else {
                        Auth.auth().signIn(withEmail: userEmail!, password: String((user?.id)!)) { result, error in
                            if let error = error {
                                print("Kakao user load error \(error.localizedDescription)")
                            } else {
                                self.currentUser = result?.user
                                Task {
                                    try await UserStore.shared.loadUserData()
                                }
                                self.signState = .signIn
                                print("Kakao user load success")
                            }
                        }
                    }
                }
            }
        }
    }
    
    // 카카오 회원가입
    func kakaoSignUp(withEmail email: String, password: String, nickName: String, gender: String, dob: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Kakao user add error \(error.localizedDescription)")
            } else {
                Task {
                    await self.uploadUserData(uid: result?.user.uid ?? "", email: email, nickName: nickName, gender: gender, dob: dob)
                }
                self.currentUser = result?.user
                Task {
                    try await UserStore.shared.loadUserData()
                }
                self.signState = .signIn
                print("Kakao user add success")
            }
        }
    }
    
    // 로그아웃
    func kakaoSignOut() {
        UserApi.shared.logout { error in
            if let error = error {
                print("Kakao logout error \(error.localizedDescription)")
            } else {
                Task {
                    try Auth.auth().signOut()
                }
                self.currentUser = nil
                UserStore.shared.currentUser = nil
                self.signState = .signOut
                UserDefaults.standard.removeObject(forKey: "SignType")
            }
        }
    }
    
    // MARK: - Facebook 로그인
    // 로그인
    func facebookSignIn(completion: @escaping () -> Void) {
        LoginManager().logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
            if let error = error {
                print("facebook Encountered Error: \(error.localizedDescription)")
            } else if let result = result, result.isCancelled {
                print("facebook Cancelled")
            } else {
                // 페이스북에서 정보 가져오기
                let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
                request.start { _, res, _ in
                    guard let profileData = res as? [String: Any] else {
                        return
                    }
                    
                    let userEmail = profileData["email"] as? String ?? ""
                    UserDefaults.standard.set("facebook", forKey: "SignType")

                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    // Firebase "user"에 데이터가 있는지 확인하기
                    Firestore.firestore().collection("users").whereField("email", isEqualTo: userEmail).getDocuments { snapshot, error in
                        // 신규
                        if snapshot!.documents.isEmpty {
                            if let error = error {
                                print("\(error.localizedDescription)")
                            } else {
                                self.signState = .signUp
                                completion()
                            }
                        }
                        // 기존
                        else {
                            Firestore.firestore().collection("users").document(userEmail).getDocument { snapshot, error in
                                Auth.auth().signIn(with: credential) { result, error in
                                    if let error = error {
                                        print("Facebook login error \(error.localizedDescription)")
                                    } else {
                                        self.currentUser = result?.user
                                        Task {
                                            try await UserStore.shared.loadUserData()
                                        }
                                        self.signState = .signIn
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func facebookSignUp(withEmail email: String, password: String, nickName: String, gender: String, dob: String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) {[unowned self] result, error in
            if let error = error {
                print("Facebook signin error \(error.localizedDescription)")
            } else {
                Task {
                    await self.uploadUserData(uid: result?.user.uid ?? "", email: email, nickName: nickName, gender: gender, dob: dob)
                }
                self.currentUser = result?.user
                Task {
                    try await UserStore.shared.loadUserData()
                }
                self.signState = .signIn
                print("Facebook signin success")
            }
        }
    }
    
    // 로그아웃
    func facebookSignOut() {
        LoginManager().logOut()
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            UserStore.shared.currentUser = nil
            self.signState = .signOut
            UserDefaults.standard.removeObject(forKey: "SignType")
        } catch {
            print("Facebook signout error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        let signtype = UserDefaults.standard.string(forKey: "SignType")
        
        if signtype == "email" {
            emailAuthSignOut()
        } else if signtype == "kakao" {
            kakaoSignOut()
        } else if signtype == "facebook" {
            facebookSignOut()
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
