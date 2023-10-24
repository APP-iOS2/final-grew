//
//  AuthRegisterEmailView.swift
//  Grew
//
//  Created by 김종찬 on 10/11/23.
//

import SwiftUI

struct AuthRegisterEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegisterViewModel
    @State private var signIndex: Int = 1
    @State private var progressBarValue: Double = 0
    @State private var progressBarTotal: Double = 100
    @State var isButton1: Bool = false
    @State var isButton2: Bool = false
    @State var isButton3: Bool = false
    @State private var isAlert: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                if signIndex != 1 {
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
                            AuthAgreeView(isButton1: $isButton1)
                            Button {
                                signIndex += 1
                            } label: {
                                Text("다음")
                                    .modifier(GrewButtonModifier(width: 330, height: 45, buttonColor: isButton1 ? .grewMainColor : Color.gray, font: Font.b2_B, fontColor: .white, cornerRadius: 10))
                                    .padding(.bottom, 50)
                            }
                            .disabled(!isButton1)
                            .onAppear(perform: {
                                progressBarValue = (100 / 3) * 1
                            })
                        } else if signIndex == 2 {
                            AuthAddMainInfoView(isButton2: $isButton2)
                            Button {
                                signIndex += 1
                            } label: {
                                Text("다음")
                                    .modifier(GrewButtonModifier(width: 330, height: 45, buttonColor: isButton2 ? .grewMainColor : Color.gray, font: Font.b2_B, fontColor: .white, cornerRadius: 10))
                                    .padding(.bottom, 50)
                            }
                            .disabled(!isButton2)
                            .onAppear(perform: {
                                progressBarValue = (100 / 3) * 2
                            })
                        } else if signIndex == 3 {
                            AuthAddDetailInfoView(isButton3: $isButton3)
                            Button {
                                isAlert.toggle()
                            } label: {
                                Text("회원가입 완료")
                                    .modifier(GrewButtonModifier(width: 330, height: 45, buttonColor: isButton3 ? .grewMainColor : Color.gray, font: Font.b2_B, fontColor: .white, cornerRadius: 10))
                                    .padding(.bottom, 50)
                            }
                            .disabled(!isButton3)
                            .onAppear(perform: {
                                progressBarValue = (100 / 3) * 3
                            })
                        }
                    }
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .grewAlert(
            isPresented: $isAlert,
            title: "회원가입이 완료되었습니다! 🎉",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .grewMainColor
        ) {
            let signtype = UserDefaults.standard.string(forKey: "SignType")
            if signtype == "kakao" {
                viewModel.kakaoCreateUser()
            } else if signtype == "email" {
                Task {
                    try await viewModel.emailCreateUser()
                }
            } else if signtype == "facebook" {
                viewModel.facebookCreateUser()
            }
        }
    }
}

#Preview {
    AuthRegisterEmailView()
        .environmentObject(RegisterViewModel())
}
