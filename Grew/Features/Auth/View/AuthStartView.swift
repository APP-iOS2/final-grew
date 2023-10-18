//
//  AuthStartView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthStartView: View {
    
    @StateObject var registerVM = RegisterVM()
    @State private var navigate: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("grewMain")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.bottom, 10)
                Text("그루")
                    .font(Font.h2_B)
                
                Spacer()
                
                Group {
                    NavigationLink {
                        AuthSignEmailView()
                            .environmentObject(registerVM)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("이메일로 로그인 하기")
                            .modifier(GrewButtonModifier(width: 330, height: 45, buttonColor: .grewMainColor, font: Font.b2_R, fontColor: .white))
                            .padding(.top, 10)
                    }
                    Button {
                        AuthStore.shared.facebookSignIn {
                            if AuthStore.shared.signState == .signUp {
                                navigate = true
                                registerVM.facebookloadData()
                            }
                        }
                    } label: {
                        Text("Facebook으로 로그인 하기")
                            .modifier(GrewButtonModifier(width: 330, height: 45, buttonColor: Color(hex: 0x1877F2), font: Font.b2_R, fontColor: .white))
                            .padding(.top, 10)
                    }
                    Button {
                        AuthStore.shared.kakaoSignIn {
                            if AuthStore.shared.signState == .signUp {
                                navigate = true
                                registerVM.kakaoloadData()
                            }
                        }
                    } label: {
                        Text("Kakao로 로그인 하기")
                            .modifier(GrewButtonModifier(width: 330, height: 45, buttonColor: Color(hex: 0xFFD233), font: Font.b2_R, fontColor: .black))
//                            .padding(.top, 10)
                    }
//                    Button {
//                        //
//                    } label: {
//                        Text("Apple로 로그인 하기")
//                            .modifier(GrewButtonModifier(width: 330, height: 45, buttonColor: Color(.black), font: Font.b2_R, fontColor: .white))
//                            .padding(.top, 10)
//                    }
//                    
//                    Button {
//                        //
//                    } label: {
//                        ZStack {
//                            Rectangle()
//                                .stroke(.blue.opacity(0.5), lineWidth: 4)
//                                .frame(width: 330, height: 45)
//                                .cornerRadius(10)
//                                .foregroundColor(Color(.white))
//                            Text("Google로 로그인 하기")
//                                .modifier(GrewButtonModifier(width: 320, height: 35, buttonColor: Color(.white), font: Font.b2_R, fontColor: .black))
//                        }
//                    }
                    .padding(.top, 10)
                }
                
                Spacer()
                
            }
            .navigationDestination(isPresented: $navigate) {
                AuthRegisterEmailView()
                    .environmentObject(registerVM)
                    .navigationBarBackButtonHidden()
            }
            .padding()
        }
    }
}

#Preview {
    AuthStartView()
}
