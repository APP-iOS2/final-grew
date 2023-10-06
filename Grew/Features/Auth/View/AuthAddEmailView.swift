//
//  AuthAddEmailView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthAddEmailView: View {
    
    @EnvironmentObject var authStore: AuthStore
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("이메일을 입력하세요")
                TextField("email", text: $authStore.email, axis: .vertical)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                
                NavigationLink {
                    AuthAddPasswordView()
                } label: {
                    Text("다음")
                }
                
            }
        }
    }
}

#Preview {
    AuthAddEmailView()
        .environmentObject(AuthStore())
}
