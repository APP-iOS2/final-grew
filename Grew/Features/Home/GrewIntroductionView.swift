//
//  GrewIntroductionView.swift
//  Grew
//
//  Created by 김효석 on 10/14/23.
//

import SwiftUI

struct GrewIntroductionView: View {
    
    let grew: Grew
    
    // 호스트 이미지, 호스트 이름 추가하기
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1696757020926-d627b01c41cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=900&q=60")) { image in
                image
                    .resizable()
                    .rounded(width: 52, height: 52)
                    .overlay(
                        Image("crown")
                            .rounded(width: 18, height: 18)
                            .background(
                                Circle()
                                    .foregroundStyle(.white)
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.Main)
                            )
                            .offset(x: 15, y: 18)
                    )
            } placeholder: {
                Image("defaultProfile")
                    .rounded(width: 52, height: 52)
                    .overlay(
                        Image("crown")
                            .rounded(width: 18, height: 18)
                            .background(
                                Circle()
                                    .foregroundStyle(.white)
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.Main)
                            )
                            .offset(x: 15, y: 18)
                    )
            }
            
            VStack(alignment: .leading) {
                Text(grew.title)
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
                        description: "\(grew.currentMembers.count)/\(grew.maximumMembers) 명"
                    )
                    makeGrewInformation(
                        imageName: "\u{26A5}",
                        title: "성별   ",
                        description: grew.gender.rawValue
                    )
                    makeGrewInformation(
                        imageName: "number",
                        title: "나이",
                        description: "\(grew.minimumAge)~\(grew.maximumAge) 세"
                    )
                    makeGrewInformation(
                        imageName: "wonsign.circle",
                        title: "활동비",
                        description: "\(grew.fee) 원"
                    )
                }
                .padding(.bottom, 3)
                
                HStack {
                    makeGrewInformation(
                        imageName: "location.circle.fill",
                        title: "장소",
                        description: grew.isOnline ? "온라인" : grew.location
                    )
                    Spacer()
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
                Text(grew.description)
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
    GrewIntroductionView(grew: Grew(
        categoryIndex: "게임/오락",
        categorysubIndex: "보드게임",
        title: "멋쟁이 보드게임",
        description: "안녕하세요!\n보드게임을 잘 해야 한다 ❌\n보드게임을 좋아한다 🅾️ \n\n즐겁게 보드게임을 함께 할 친구들이 필요하다면,\n<멋쟁이 보드게임> 그루에 참여하세요!\n\n매주 수요일마다 모이는 정기 모임과\n자유롭게 모이는 번개 모임을 통해\n많은 즐거운 추억을 쌓을 수 있어요 ☺️\n\n",
        imageURL: "https://images.unsplash.com/photo-1696757020926-d627b01c41cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=900&q=60",
        isOnline: false,
        location: "서울특별시 서울특별시",
        gender: .any,
        minimumAge: 20,
        maximumAge: 40,
        maximumMembers: 8,
        currentMembers: ["id1", "id2"],
        isNeedFee: false,
        fee: 0
    ))
}
