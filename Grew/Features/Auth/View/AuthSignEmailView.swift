//
//  AuthSignEmailView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthSignEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var registerVM: RegisterVM
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isWrongText: Bool = false
    @State private var isTextfieldDisabled: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 25))
                            .foregroundStyle(Color.black)
                            .padding()
                    }
                }

                Text("로그인")
                    .font(Font.b1_B)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("이메일(아이디)")
                        .font(Font.b2_L)
                    GrewTextField(text: $email, isWrongText: $isWrongText, isTextfieldDisabled: $isTextfieldDisabled, placeholderText: "이메일", isSearchBar: false)
                    
                    Text("비밀번호")
                        .font(Font.b2_L)
                        .padding(.top, 15)
                    GrewSecureField(text: $password, isWrongText: $isWrongText, isTextfieldDisabled: $isTextfieldDisabled, placeholderText: "비밀번호")
                }
                .padding()
                
                Spacer()
                
                Group {
                    Button {
                        Task {
                            try await AuthStore.shared.emailAuthSignIn(withEmail: email, password: password)
                        }
                    } label: {
                        Text("로그인")
                            .modifier(GrewButtonModifier(width: 330, height: 45, buttonColor: .grewMainColor, font: Font.b2_B, fontColor: .white, cornerRadius: 10))
                    }
                    
                    NavigationLink {
                        AuthRegisterEmailView()
                            .environmentObject(registerVM)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("회원가입")
                            .underline()
                            .font(Font.b2_B)
                            .foregroundStyle(.gray)
                            .padding(.top, 5)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        UserDefaults.standard.set("email", forKey: "SignType")
                    })
                }
                Spacer()
            }
        }
    }
}

#Preview {
    AuthSignEmailView()
        .environmentObject(RegisterVM())
}
