//
//  RegisterVM.swift
//  Grew
//
//  Created by 김종찬 on 10/11/23.
//

import Foundation

class RegisterVM: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var nickName: String = ""
    @Published var dob: String = ""
    @Published var gender: Gender = .female
    
    func createUser() async throws {
        try await AuthStore.shared.emailAuthSignUp(withEmail: email, password: password, nickName: nickName, gender: gender.rawValue, dob: dob)
    }
    
    
}
