//
//  AuthAgreeCheckView.swift
//  Grew
//
//  Created by 김종찬 on 10/10/23.
//

import SwiftUI

struct AuthAgreeCheckView: View {
    
    @Binding var isButton1: Bool
    @State private var isCheck1: Bool = false
    @State private var isCheck2: Bool = false
    @State private var isCheck3: Bool = false
    private var checkAll: Bool {
        if isCheck1 && isCheck2 && isCheck3 {
            return true
        } else {
            return false
        }
    }
    
    func isCheckAll() {
        if isCheck1 && isCheck2 && isCheck3 {
            isCheck1.toggle()
            isCheck2.toggle()
            isCheck3.toggle()
        } else {
            if !isCheck1 {
                isCheck1.toggle()
            }
            if !isCheck2 {
                isCheck2.toggle()
            }
            if !isCheck3 {
                isCheck3.toggle()
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        isCheckAll()
                    } label: {
                        if isCheck1 && isCheck2 && isCheck3 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(Color(hex: 0xFF7E00))
                                    .frame(width: 30, height: 30)
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.white)
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color.gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                    Text("전체 동의")
                        .font(Font.b2_R)
                }
                
                Divider()
                    .padding()
                
                HStack {
                    Button {
                        isCheck1.toggle()
                    } label: {
                        if isCheck1 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(Color(hex: 0xFF7E00))
                                    .frame(width: 30, height: 30)
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.white)
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color.gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                    NavigationLink {
                        AgreeUseView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("이용 약관")
                            .font(Font.b2_L)
                            .foregroundStyle(Color.black)
                        Text("(필수)")
                            .font(Font.b2_L)
                            .foregroundStyle(Color(hex: 0xFF7E00))
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundStyle(Color(hex: 0xFF7E00))
                    }
                }
                HStack {
                    Button {
                        isCheck2.toggle()
                    } label: {
                        if isCheck2 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(Color(hex: 0xFF7E00))
                                    .frame(width: 30, height: 30)
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.white)
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color.gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                    NavigationLink {
                        AgreeUserDataView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("개인정보 처리방침")
                            .font(Font.b2_L)
                            .foregroundStyle(Color.black)
                        Text("(필수)")
                            .font(Font.b2_L)
                            .foregroundStyle(Color(hex: 0xFF7E00))
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundStyle(Color(hex: 0xFF7E00))
                    }
                }
                HStack {
                    Button {
                        isCheck3.toggle()
                    } label: {
                        if isCheck3 {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(Color(hex: 0xFF7E00))
                                    .frame(width: 30, height: 30)
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.white)
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color.gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                    NavigationLink {
                        AgreeLocationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("위치 제공 서비스")
                            .font(Font.b2_L)
                            .foregroundStyle(Color.black)
                        Text("(필수)")
                            .font(Font.b2_L)
                            .foregroundStyle(Color(hex: 0xFF7E00))
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundStyle(Color(hex: 0xFF7E00))
                    }
                }
            }
            .onChange(of: checkAll) {
                isButton1 = checkAll ? true : false
            }
            .padding(30)
        }
    }
}

#Preview {
    AuthAgreeCheckView(isButton1: .constant(true))
        .environmentObject(RegisterViewModel())
}
