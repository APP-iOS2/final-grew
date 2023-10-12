//
//  AuthAddEmailView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthAddMainInfoView: View {
    
    @EnvironmentObject var registerVM: RegisterVM
    @State private var checkPassword: String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("이메일(아이디)")
                    .font(Font.b2_L)
                TextField("email", text: $registerVM.email, axis: .vertical)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                Text("비밀번호")
                    .font(Font.b2_L)
                SecureField("password", text: $registerVM.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                Text("비밀번호 확인")
                    .font(Font.b2_L)
                SecureField("check password", text: $checkPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
            }
            .padding(20)
            
            Spacer()
        }
    }
}

#Preview {
    AuthAddMainInfoView()
}
