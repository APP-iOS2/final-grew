//
//  GrewAlertModifier.swift
//  Grew
//
//  Created by 김효석 on 10/10/23.
//

import SwiftUI

struct GrewAlertModifier: ViewModifier {
    @Binding var ispresented: Bool
    let title: String
    let buttonTitle: String
    let buttonColor: Color
    let action: () -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            if ispresented {
                Rectangle()
                    .fill(.black.opacity(0.2))
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text(title)
                        .font(.h2_R)
                        .foregroundStyle(.black)
                    
                    Button {
                        action()
                        ispresented.toggle()
                    } label: {
                        Text(buttonTitle)
                            .font(.b1_R)
                            .foregroundColor(.white)
                            .padding(.horizontal, 60)
                            .padding(.vertical, 10)
                    }
                    .background(buttonColor)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
                    
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 30)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.grewMainColor.opacity(0.5))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                        )
                )
            }
        }
    }
}

#Preview {
    Text("Alert Test")
        .modifier(
            GrewAlertModifier(
                ispresented: .constant(true),
                title: "회원가입이 완료되었습니다! 🎉",
                buttonTitle: "확인",
                buttonColor: .grewMainColor,
                action: { }
            )
        )
    
//    Text("Alert Test")
//        .modifier(
//            GrewAlertModifier(
//                ispresented: .constant(true),
//                title: "존재하지 않는 계정입니다.",
//                buttonTitle: "확인",
//                buttonColor: Color(hexCode: "F05650"),
//                action: { }
//            )
//        )
}
