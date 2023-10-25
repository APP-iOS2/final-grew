//
//  GrewAlertModifier.swift
//  Grew
//
//  Created by 김효석 on 10/10/23.
//

import SwiftUI

struct GrewAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let buttonTitle: String
    let buttonColor: Color
    let action: () -> Void
    
    let secondButtonTitle: String?
    let secondButtonColor: Color?
    let secondButtonAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                content
                
                if isPresented {
                    Rectangle()
                        .fill(.black.opacity(0.2))
                        .ignoresSafeArea()
                    
                    VStack(spacing: 30) {
                        Text(title)
                            .font(.b1_R)
                            .foregroundStyle(.black)
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                        
                        HStack {
                            if let secondButtonTitle, let secondButtonColor, let secondButtonAction {
                                Button {
                                    secondButtonAction()
                                    isPresented.toggle()
                                } label: {
                                    Text(secondButtonTitle)
                                        .font(.b1_R)
                                        .foregroundColor(.white)
                                        .frame(width: 100, height: 44)
                                }
                                .background(secondButtonColor)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 5)
                                )
                            }
                            
                            Button {
                                action()
                                isPresented.toggle()
                                
                            } label: {
                                Text(buttonTitle)
                                    .font(.b1_R)
                                    .foregroundColor(.white)
                                    .frame(
                                        width: secondButtonTitle == nil ? 180 : 100,
                                        height: 44
                                    )
                            }
                            .background(buttonColor)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                        }
                        
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 30)
                    .frame(width: geometry.size.width * 0.8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                            )
                    )
                }
            }
        }
    }
}

#Preview {
    Text("Alert")
        .modifier(
            GrewAlertModifier(
                isPresented: .constant(true),
                title: "회원가입이 완료되었습니다! 🎉 \n완료되었습니다!",
                buttonTitle: "확인",
                buttonColor: .grewMainColor,
                action: { },
                secondButtonTitle: "취소",
                secondButtonColor: .red,
                secondButtonAction: { }
            )
        )
}
