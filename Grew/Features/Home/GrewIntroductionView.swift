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
                        description: "20000 원"
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
        
        VStack {
            HStack {
                Text("소개글")
                    .font(.b3_B)
                Spacer()
            }
            
            Text("""
                asdfasdf
                asdfasd
                asdfasdf
                asdf
                asd
                fasd
                f
                asdf
                asd
                f
                asf
                asd
                fa
                sdf
                asd
                fa
                sdf
                ad
                s
                
                """)
            .font(.b3_R)
        }
        .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
    }
    
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
