//
//  GrewScheduleCell.swift
//  Grew
//
//  Created by 정유진 on 2023/10/10.
//

import SwiftUI

struct GrewScheduleCell: View {
    let grew: Grew
    @State private var heartButton: Bool = false
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .topTrailing){
                // Grew 이미지 가져오기
                GrewScheduleImage(image: grew.imageURL)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)

                    .cornerRadius(12)

                Button {
                    heartButton.toggle()
                } label: {
                    Image(systemName: heartButton ? "heart.fill" : "heart")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                }
                .padding(.top, 10)
                .padding(.trailing, 10)
                
            }
            
            VStack(alignment: .leading, spacing: 16) {
                /// 제목
                Text("에스파 콘서트")
                    
                    .foregroundStyle(Color.gray)
                /// 날짜
                HStack {
                    Image(systemName: "calendar")
                    Text("바로 오늘")
                        .font(.title3)
                }
                /// 지역, 참여
                HStack {
                    Text((grew.isOnline ? "온라인" : grew.location.split(separator: " ").first) ?? "위치 모름")
                        

                    Group {
                        Text("|")
                            .padding(.horizontal, -5)
                        Text("참여")
                            .padding(.horizontal, -5)
                        Text("\(grew.currentMembers.count)/\(grew.maximumMembers)")
                    }
                    .foregroundStyle(Color.gray)
                }
            }
            
            Spacer()
            
        }
        
        .fontWeight(.heavy)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1.5)
                .opacity(0.3)
        )
        
        
    }
}



#Preview {
    GrewScheduleCell(grew: Grew(
        categoryIndex: "123",
        categorysubIndex: "345",
        title: "123",
        description: "123",
        imageURL: "https://image.newsis.com/2023/05/25/NISI20230525_0001274814_web.jpg",
        isOnline: true,
        location: "강남구",
        gender: .male,
        minimumAge: 12,
        maximumAge: 12,
        maximumMembers: 12,
        currentMembers: ["1", "2"],
        isNeedFee: true,
        fee: 0)
    )
}
