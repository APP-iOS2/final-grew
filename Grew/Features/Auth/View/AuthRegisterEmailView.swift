//
//  AuthRegisterEmailView.swift
//  Grew
//
//  Created by 김종찬 on 10/11/23.
//

import SwiftUI

struct AuthRegisterEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var registerVM: RegisterVM
    @State private var signIndex: Int = 1
    @State private var progressBarValue: Double = 0
    @State private var progressBarTotal: Double = 100
    
    var body: some View {
        HStack {
            if signIndex != 1{
                Button {
                    signIndex -= 1
                } label: {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 25))
                        .foregroundStyle(Color.black)
                        .padding()
                }
            }
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
        .padding(.horizontal)
        VStack {
            Text("그루 회원가입")
                .font(Font.h2_B)
            VStack(spacing: 0) {
                ProgressView(value: progressBarValue, total: progressBarTotal)
                    .progressViewStyle(AuthProgressBar(
                        value: $progressBarValue,
                        total: $progressBarTotal))
                    .frame(height: 50)
            }
            ZStack {
                VStack {
                    if signIndex == 1 {
                        AuthAgreeView()
                            .onAppear(perform: {
                                progressBarValue = (100 / 3) * 1
                            })
                    } else if signIndex == 2 {
                        AuthAddMainInfoView()
                            .onAppear(perform: {
                                progressBarValue = (100 / 3) * 2
                            })
                    } else if signIndex == 3 {
                        AuthAddDetailInfoView()
                            .onAppear(perform: {
                                progressBarValue = (100 / 3) * 3
                            })
                    }
                    if signIndex == 3 {
                        Button {
                            print(registerVM.email)
                            print(registerVM.nickName)
                            print(registerVM.dob)
                            print(registerVM.gender.rawValue)
                            Task {
                                try await registerVM.createUser()
                            }
                            dismiss()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 330, height: 45)
                                    .cornerRadius(10)
                                    .foregroundColor(Color(hex: 0x25C578))
                                Text("회원가입 완료")
                                    .font(Font.b2_B)
                                    .foregroundStyle(.white)
                            }
                            .padding(.bottom, 50)
                        }

                    } else {
                        Button {
                            signIndex += 1
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 330, height: 45)
                                    .cornerRadius(10)
                                    .foregroundColor(Color(hex: 0x25C578))
                                Text("다음")
                                    .font(Font.b2_B)
                                    .foregroundStyle(.white)
                            }
                            .padding(.bottom, 50)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AuthRegisterEmailView()
}
