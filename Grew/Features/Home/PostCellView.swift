//
//  PostView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct PostCellView: View {
    
    let grew: TempGrew
    /// 즐겨찾기? 버튼이 유저, Grew 각각 들어가야함
    @State private var heartButton: Bool = false
    
    var body: some View {
        
        HStack {
            
            ZStack(alignment: .bottomLeading){
                
                PostImageView(image: grew.imageURL)
                
                Button {
                    heartButton.toggle()
                } label: {
                    Image(systemName: heartButton ? "heart.fill" : "heart")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 13)
                .padding(.leading, 13)
            }
            
            VStack(alignment: .leading) {
                
                // 모임 카테고리
                Text("\(grew.category)")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .background(.pink)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .font(.footnote)
                
                // 모임 제목
                Text(grew.title)
                    .font(.title3)
                    .offset(y: -5)
                
                Spacer()
                HStack {
                    // 모임 온/오프라인
                    Text(grew.isOnline ? "온라인" : "오프라인")
                    Image(systemName: "person.2.fill")
                    // 모임 정원
                    HStack {
                        Text("\(grew.currentMembers.count)")
                        
                        Text("/")
                            .padding(.horizontal, -5)
                        Text("\(grew.maximumMembers)")
                            .padding(.horizontal, -5)
                    }
                }
                .font(.footnote)
            }
            .frame(height: 110)
            
            Spacer()
        }
        .padding(10)
        .fontWeight(.heavy)
        .frame(maxWidth: .infinity)
        .frame(height: 130)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1.5)
                .opacity(0.3)
        )
        
        
        
        
    }
}

#Preview {
    PostCellView(grew: TempGrew(category: "123",
    title: "123",
    description: "123",
    imageURL: "https://image.newsis.com/2023/05/25/NISI20230525_0001274814_web.jpg",
    isOnline: true,
    location: "123",
    gender: .male,
    minimumAge: 12,
    maximumAge: 12,
    maximumMembers: 12,
    currentMembers: ["1", "2"],
    isNeedFee: true,
    fee: 0))
}
