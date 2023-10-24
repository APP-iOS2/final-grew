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
                    button
                }
            }
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
extension AuthRegisterEmailView {
    var button: some View {
        NavigationStack {
            VStack {
                if signIndex == 1 {
                    AuthAgreeView(isButton1: $isButton1)
                        .onAppear(perform: {
                            progressBarValue = (100 / 3) * 1
                        })
                } else if signIndex == 2 {
                    AuthAddMainInfoView(isButton2: $isButton2)
                        .onAppear(perform: {
                            progressBarValue = (100 / 3) * 2
                        })
                } else if signIndex == 3 {
                    AuthAddDetailInfoView(isButton3: $isButton3)
                        .onAppear(perform: {
                            progressBarValue = (100 / 3) * 3
                        })
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    
                    Button{
                        if signIndex < 3 {
                            signIndex += 1
                        } else {
                            isAlert.toggle()
                        }
                    } label: {
                        Text(signIndex == 3 ? "회원가입 완료" : "닫기")
                            .modifier(GrewButtonModifier(width: 330, height: 45,
                                                         buttonColor: signIndex == 1 && !isButton1 ||
                                                         signIndex == 2 && !isButton2 ||
                                                         signIndex == 3 && !isButton3 ? .LightGray2 : .Main,
                                                         font: Font.b2_B, fontColor: .white, cornerRadius: 10))
                    }
                    .disabled(signIndex == 1 && !isButton1 || signIndex == 2 && !isButton2 || signIndex == 3 && !isButton3)
                    
                }
            }
        }
    }
}

#Preview {
    AuthRegisterEmailView()
        .environmentObject(RegisterViewModel())
}
