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
        ZStack {
            ScrollView {
                Text("그루터기 소개 및 설명")
                    .font(.b1_B)
            }
            VStack {
                Spacer()
                Button {
                    isShowingRequestSheet.toggle()
                } label: {
                    Text("그루터기 멤버 신청하기")
                }
                .grewButtonModifier(width: 343, height: 50, buttonColor: .Main, font: .b1_B, fontColor: .white, cornerRadius: 8)
                .padding(.bottom)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("그루터기 신청")
                    .font(.b1_B)
            }
        }
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
