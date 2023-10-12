//
//  AuthAgreeView.swift
//  Grew
//
//  Created by 김종찬 on 10/10/23.
//

import SwiftUI

struct AuthAgreeView: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Text("환영합니다!")
                    .font(Font.b2_B)
                    .padding(.bottom, 10)
                Text("회원가입을 위해 아래의 이용 약관,\n개인정보 처리방침, 위치 서비스에 동의해 주세요.")
                    .font(Font.b2_R)
            }
            .padding(.bottom, 10)
            
            AuthAgreeCheckView()
            
            Spacer()
        }
    }
}

#Preview {
    AuthAgreeView()
}
