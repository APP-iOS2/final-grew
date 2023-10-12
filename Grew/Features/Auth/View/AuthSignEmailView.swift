//
//  AuthSignEmailView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthSignEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject var registerVM = RegisterVM()
    
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
                    TextField("email", text: $email, axis: .horizontal)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    
                    Text("비밀번호")
                        .font(Font.b2_L)
                        .padding(.top, 15)
                    SecureField("password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                }
                .padding()
                
                Spacer()
                
                Group {
                    Button {
                        Task {
                            try await AuthStore.shared.emailAuthSignIn(withEmail: email, password: password)
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 330, height: 45)
                                .cornerRadius(10)
                                .foregroundColor(Color(hex: 0x25C578))
                            Text("로그인")
                                .font(Font.b2_B)
                                .foregroundStyle(.white)
                        }
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
                    
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    AuthSignEmailView()
}
