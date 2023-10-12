//
//  AuthStartView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthStartView: View {
    
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
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 330, height: 45)
                                .cornerRadius(10)
                                .foregroundColor(Color(hex: 0x25C578))
                            Text("이메일로 로그인 하기")
                                .font(Font.b2_R)
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 10)
                    }
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 330, height: 45)
                                .cornerRadius(10)
                                .foregroundColor(Color(hex: 0x1877F2))
                            Text("Facebook으로 로그인 하기")
                                .font(Font.b2_R)
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 10)
                    }
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 330, height: 45)
                                .cornerRadius(10)
                                .foregroundColor(Color(hex: 0xFFD233))
                            Text("Kakao로 로그인 하기")
                                .font(Font.b2_R)
                                .foregroundStyle(.black)
                        }
                        .padding(.top, 10)
                    }
                    Button {
                        //
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 330, height: 45)
                                .cornerRadius(10)
                                .foregroundColor(Color(.black))
                            Text("Apple로 로그인 하기")
                                .font(Font.b2_R)
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 10)
                    }
                    
                    Button {
                        //
                    } label: {
                        ZStack {
                            Rectangle()
                                .stroke(.blue.opacity(0.5), lineWidth: 4)
                                .frame(width: 330, height: 45)
                                .cornerRadius(10)
                                .foregroundColor(Color(.white))
                            Text("Google로 로그인 하기")
                                .font(Font.b2_R)
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(.top, 10)
                }
                
                Spacer()
                
            }
            .padding()
        }
    }
}

#Preview {
    AuthStartView()
}
