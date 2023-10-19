//
//  GrootView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct GrootView: View {
    var body: some View {
        HStack {
            Image(.defaultProfile)
                .rounded(width: 44, height: 44)
                .padding(.trailing, 1)
            VStack(alignment: .leading) {
                HStack {
                    Text("이승준")
                        .font(.b3_B)
                        .padding([.trailing, .bottom], 1)
                    Text("NEW")
                        .font(.c2_B)
                        .foregroundStyle(Color.Sub)
                }
                Text("잘 부탁드립니다. 가입 문의는 DM 주세요!")
                    .font(.c1_L)
            }
            Spacer()
        }
    }
}

#Preview {
    GrootView()
}
