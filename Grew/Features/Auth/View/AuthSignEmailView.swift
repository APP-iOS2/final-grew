//
//  AuthSignEmailView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthSignEmailView: View {
    
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Spacer()
                
                //  앱 로고, 이미지 만들어지면 바꾸기
                Text("Grew")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 50)
                
                Spacer()
                
                Group {
                    TextField("email", text: $authStore.email, axis: .horizontal)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("password", text: $authStore.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                }
                
                Spacer()
                
                Group {
                    NavigationLink {
                        MainTabView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Login")
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        Task {
                            try await authStore.emailAuthSignIn()
                        }
                    })
                    .padding()
                    
                    NavigationLink {
                        AuthAddEmailView()
                    } label: {
                        Text("Signup")
                    }
                    
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    AuthSignEmailView()
        .environmentObject(AuthStore())
}
