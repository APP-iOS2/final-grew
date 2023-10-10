//
//  AuthAddPasswordView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthAddPasswordView: View {
    
    @EnvironmentObject var authStore: AuthStore
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("비밀번호를 입력하세요")
                SecureField("password", text: $authStore.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
//                Text("비밀번호 확인")
//                SecureField("password", text: $checkPassword)
                
                NavigationLink {
                    AuthAddDetailView()
                } label: {
                    Text("다음")
                }
            }
        }
    }
}

#Preview {
    AuthAddPasswordView()
        .environmentObject(AuthStore())
}
