//
//  AuthAddEmailView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthAddMainInfoView: View {
    
    @Binding var isButton2: Bool
    @EnvironmentObject var registerVM: RegisterVM
    @State private var isTextfieldDisabled: Bool = false
    @State private var isWrongEmail: Bool = false
    @State private var isWrongPassword: Bool = false
    @State private var isSamePassword: Bool = false
    private var writeAllTextField: Bool {
        if isWrongEmail || isWrongPassword || isSamePassword || registerVM.checkPassword.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("이메일(아이디)")
                    .font(Font.b2_L)
                GrewTextField(text: $registerVM.email, isWrongText: isWrongEmail, isTextfieldDisabled: isTextfieldDisabled, placeholderText: "이메일", isSearchBar: false)
                    .onChange(of: registerVM.email) {
                        isWrongEmail = !(registerVM.isValidEmail(registerVM.email))
                    }
                
                Text("비밀번호")
                    .font(Font.b2_L)
                GrewSecureField(text: $registerVM.password, isWrongText: $isWrongPassword, isTextfieldDisabled: $isTextfieldDisabled, placeholderText: "비밀번호")
                    .onChange(of: registerVM.password) {
                        isWrongPassword = !(registerVM.isValidPassword(registerVM.password))
                    }
                
                Text("비밀번호 확인")
                    .font(Font.b2_L)
                GrewSecureField(text: $registerVM.checkPassword, isWrongText: $isSamePassword, isTextfieldDisabled: $isTextfieldDisabled, placeholderText: "비밀번호 확인")
                    .onChange(of: registerVM.checkPassword) {
                        isSamePassword = registerVM.isSamePassword(registerVM.password, registerVM.checkPassword)
                    }
            }
            .onChange(of: writeAllTextField) {
                isButton2 = writeAllTextField ? true : false
            }
            .onAppear {
                if UserDefaults.standard.string(forKey: "SignType") != "email" {
                    isTextfieldDisabled = true
                    isButton2 = true
                }
            }
            .padding(20)
            
            Spacer()
        }
    }
}

#Preview {
    AuthAddMainInfoView(isButton2: .constant(true))
        .environmentObject(RegisterVM())
}
