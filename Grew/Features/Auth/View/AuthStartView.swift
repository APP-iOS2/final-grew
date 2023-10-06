//
//  AuthStartView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthStartView: View {
    
    @EnvironmentObject var authStore: AuthStore
    
    var body: some View {
        VStack {
            Spacer()
            
            //  앱 로고, 이미지 만들어지면 바꾸기
            Text("Grew")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            Group {
                //                Button {
                //                    authStore.facebookSignIn()
                //                } label: {
                //                    Image("facebooklogin")
                //                        .resizable()
                //                        .scaledToFit()
                //                        .padding(.bottom, 10)
                //                        .frame(width: 300)
                //                }
                //                Button {
                //                    authStore.kakaoSignIn()
                //                } label: {
                //                    Image("kakaologin")
                //                        .resizable()
                //                        .scaledToFit()
                //                        .padding(.bottom, 10)
                //                        .frame(width: 300)
                //                }
                
                NavigationLink {
                    AuthSignEmailView()
                        .environmentObject(AuthStore())
                } label: {
                    Text("Continue with E-mail")
                        .padding()
                }
                
//                Button {
//                    //
//                } label: {
//                    Text("Continue with Google")
//                        .padding()
//                }
//                
//                Button {
//                    //
//                } label: {
//                    Text("Continue with Apple")
//                        .padding()
//                }
                
            }
            
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    AuthStartView()
        .environmentObject(AuthStore())
}
