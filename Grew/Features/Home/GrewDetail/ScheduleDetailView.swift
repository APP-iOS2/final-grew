//
//  ScheduleDetailView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct ScheduleDetailView: View {
    var rows: [GridItem] = Array(repeating: .init(.fixed(44)), count: 1)
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                VStack {}//: VStack
                .frame(width: UIScreen.screenWidth, height: 120)
                .background(Color.grewMainColor)
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        HStack{
                            Text("방장")
                                .font(.b3_B)
                            Text("이승준")
                                .font(.b3_R)
                        }//: HStack
                    }//: HStack
                    Text("방탈출 보드게임")
                        .font(.b1_B)
                        .padding(.vertical, 20)
                    Text("날짜, 시간")
                        .font(.b3_B)
                        .padding(.bottom, 5)
                    Text("2023.10.25(수) 18:30")
                        .font(.b3_R)
                        .padding(.bottom, 20)
                    Text("참여비")
                        .font(.b3_B)
                        .padding(.bottom, 5)
                    Text("20,000원")
                        .font(.b3_R)
                        .padding(.bottom)
                    HStack {
                        Text("장소")
                            .font(.b3_B)
                        Spacer()
                        Text("\(Image(systemName: "map.fill")) 지도 보기")
                            .font(.b3_R)
                    }
                    .padding(.bottom, 5)
                    Text("서울 강남구 테헤란로1길 29 4층 데블다이스")
                        .font(.b3_R)
                        .padding(.bottom)
                    HStack {
                        Text("참여 인원")
                            .font(.b3_B)
                        Spacer()
                        Text("13 / 25명 참여 중")
                            .font(.b3_R)
                    }
                    .padding(.bottom, 5)
                }//: VStack
                .padding(.top, 20)
                .padding(.horizontal, 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, content: {
                        ForEach(0...10, id: \.self) { _ in
                            Image(.defaultProfile)
                                .rounded(width: 44, height: 44)
                        }
                    })//: LazyHGrid
                    .padding(.horizontal, 20)
                }//: ScrollView
                .frame(height: 44)
                Spacer()
                Button {
                    
                } label: {
                    Text("참여하기")
                }
                .grewButtonModifier(width: UIScreen.screenWidth - 40, height: 44, buttonColor: .grewMainColor, font: .b1_B, fontColor: .white, cornerRadius: 8)
            }//: VStack
            ProfileCircleImageView(size: 80)
                .offset(x: 20, y: 80)
        }//: ZStack

    }
}

#Preview {
    ScheduleDetailView()
}
