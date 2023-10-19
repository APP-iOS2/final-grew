//
//  StumpIntroductionView.swift
//  Grew
//
//  Created by 김효석 on 10/18/23.
//

import SwiftUI

struct StumpIntroductionView: View {
    
    @State private var isShowingRequestSheet: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                Divider()
                Text("그루터기 소개 및 설명")
                    .font(.b1_B)
                    .padding(.top)
                
                Text("""
                
                그루터기는 초목을 베고 남은 밑동을 가르키는 순우리말이에요.
                다른 말로는 '뿌리그루'라고 하기도 하지요.
                
                나무를 베면 밑에 두꺼운 뿌리부분만 남는데,
                순우리말로 이것을 그루터기라고 한답니다.
                
                Grew에서는 **🌳그루**는 모임원과 운영진
                즉, 커뮤니티 유저를 가르키고,
                **🧑‍🌾그루터기**는 그루들에게 장소를 제공해주는
                사장님들을 뜻해요.
                
                **그루터기 멤버**가 되어 그루들이 사용할 장소를 제공해보세요!
                (어쩌구)
                
                """)
                .font(.b1_L)
                .lineSpacing(10)
            }
            VStack {
                Button {
                    isShowingRequestSheet.toggle()
                } label: {
                    Text("그루터기 멤버 신청하기")
                }
                .grewButtonModifier(width: 343, height: 50, buttonColor: .Main, font: .b1_B, fontColor: .white, cornerRadius: 8)
            }
        }
        .navigationTitle("그루터기 신청")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $isShowingRequestSheet) {
            StumpMemberRequestView(isShowingRequestSheet: $isShowingRequestSheet)
        }
    }
}

#Preview {
    NavigationStack {
        StumpIntroductionView()
    }
}