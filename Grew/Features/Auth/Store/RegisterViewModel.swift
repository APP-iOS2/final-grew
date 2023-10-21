//
//  RegisterVM.swift
//  Grew
//
//  Created by 김종찬 on 10/11/23.
//

import FBSDKLoginKit
import Foundation
import KakaoSDKUser

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var checkPassword: String = ""
    @Published var nickName: String = ""
    @Published var dob: String = ""
    @Published var gender: Gender = .female
    
    func emailCreateUser() async throws {
        try await AuthStore.shared.emailAuthSignUp(withEmail: email, password: password, nickName: nickName, gender: gender.rawValue, dob: dob)
        self.nickName = ""
        self.email = ""
        self.password = ""
        self.checkPassword = ""
        self.dob = ""
    }
    
    func kakaoCreateUser() {
        AuthStore.shared.kakaoSignUp(withEmail: email, password: password, nickName: nickName, gender: gender.rawValue, dob: dob)
        self.nickName = ""
        self.email = ""
        self.password = ""
        self.checkPassword = ""
        self.dob = ""
    }
    
    func facebookCreateUser() {
        AuthStore.shared.facebookSignUp(withEmail: email, password: password, nickName: nickName, gender: gender.rawValue, dob: dob)
        self.nickName = ""
        self.email = ""
        self.password = ""
        self.checkPassword = ""
        self.dob = ""
    }
    
    func kakaoloadData() {
        UserApi.shared.me { user, error in
            if let error = error {
                print("Kakao user data error \(error.localizedDescription)")
            } else {
                self.nickName = (user?.kakaoAccount?.profile?.nickname)!
                self.email = (user?.kakaoAccount?.email!)!
                self.password = String((user?.id)!)
                self.checkPassword = String((user?.id)!)
            }
        }
    }
    
    func facebookloadData() {
        let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
        request.start { _, res, _ in
            guard let profileData = res as? [String: Any] else {
                return
            }
            
            self.nickName = profileData["name"] as? String ?? ""
            self.email = profileData["email"] as? String ?? ""
            self.password = profileData["id"] as? String ?? ""
            self.checkPassword = profileData["id"] as? String ?? ""
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^[A-Za-z0-9~!@#$%^&*]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)

        return passwordPredicate.evaluate(with: password)
    }
    
    func isValidName(_ name: String) -> Bool {
        let nameRegex = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z]{2,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)

        return namePredicate.evaluate(with: name)
    }
    
    func isValiddob(_ dob: String) -> Bool {
        let dobRegex = "^([0-9]{4})(0|1)([0-9])([0-3])([0-9])$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", dobRegex)
        
        return passwordPredicate.evaluate(with: dob)
    }
    
    func isSamePassword(_ password: String, _ checkPassword: String) -> Bool {
        if password == checkPassword {
            return false
        } else {
            return true
        }
    }
}
