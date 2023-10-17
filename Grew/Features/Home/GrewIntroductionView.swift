//
//  GrewIntroductionView.swift
//  Grew
//
//  Created by 김효석 on 10/14/23.
//

import SwiftUI

struct GrewIntroductionView: View {
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1557862921-37829c790f19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bWFufGVufDB8fDB8fHww&auto=format&fit=crop&w=900&q=60")) { image in
                image
                    .resizable()
                    .rounded(width: 52, height: 52)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text("멋쟁이 보드게임")
                    .font(.b2_B)
                    .padding(.bottom, 2)
                
                Text("호스트 kangho")
                    .font(.c1_B)
                    .padding(.bottom, 3)
                
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(minimum: 120, maximum: 120), spacing: 10),
                        GridItem(.flexible(minimum: 120, maximum: 120))],
                    alignment: .leading,
                    spacing: 7
                ) {
                    makeGrewInformation(
                        imageName: "person.2.fill",
                        title: "인원",
                        description: "3/7 명"
                    )
                    makeGrewInformation(
                        imageName: "\u{26A5}",
                        title: "성별   ",
                        description: "누구나"
                    )
                    makeGrewInformation(
                        imageName: "number",
                        title: "나이",
                        description: "00"
                    )
                    makeGrewInformation(
                        imageName: "wonsign.circle",
                        title: "활동비",
                        description: "20,000 원"
                    )
                    makeGrewInformation(
                        imageName: "location.circle.fill",
                        title: "장소",
                        description: "온라인"
                    )
                }
            }
            
            Spacer()
        }
        .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
        
        Divider()
        
        VStack(alignment: .leading) {
            HStack {
                Text("소개글")
                    .font(.b3_B)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 10, trailing: 20))
                Spacer()
            }
            
            HStack {
                Text("""
                     안녕하세요! 보드게임을 잘 해야 한다 ❌ 보드게임을 좋아한다 🅾️
                     즐겁게 보드게임을 함께 할 친구들이 필요하다면, <멋쟁이 보드게임> 그루에 참여하세요!
                     매주 수요일마다 모이는 정기 모임과 자유롭게 모이는 번개 모임을 통해 많은 즐거운 추억을 쌓을 수 있어요 ☺️
                     
                     안녕하세요! 보드게임을 잘 해야 한다 ❌ 보드게임을 좋아한다 🅾️
                     즐겁게 보드게임을 함께 할 친구들이 필요하다면, <멋쟁이 보드게임> 그루에 참여하세요!
                     매주 수요일마다 모이는 정기 모임과 자유롭게 모이는 번개 모임을 통해 많은 즐거운 추억을 쌓을 수 있어요 ☺️
                     
                     안녕하세요! 보드게임을 잘 해야 한다 ❌ 보드게임을 좋아한다 🅾️
                     즐겁게 보드게임을 함께 할 친구들이 필요하다면, <멋쟁이 보드게임> 그루에 참여하세요!
                     매주 수요일마다 모이는 정기 모임과 자유롭게 모이는 번개 모임을 통해 많은 즐거운 추억을 쌓을 수 있어요 ☺️
                     """)
                .font(.b3_R)
                .padding(.horizontal, 20)
                .lineSpacing(5)
                Spacer()
            }
        }
    }
    
    /// Grew 세부 정보 View
    func makeGrewInformation(imageName: String, title: String, description: String) -> some View {
        HStack {
            if imageName == "\u{26A5}" {
                Text(imageName)
                    .frame(width: 13)
                    .font(.b1_B)
            } else {
                Image(systemName: imageName)
                    .frame(width: 13)
            }
            Text(title)
            Text(description)
        }
        .font(.c1_R)
    }
}

#Preview {
    GrewIntroductionView()
}
