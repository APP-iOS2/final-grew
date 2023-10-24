//
//  GrootListView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct GrootListView: View {
    
    let grew: Grew
    @State var selection: SelectViews = SelectViews.profile
    var body: some View {
        VStack(spacing: 16, content: {
            ForEach(grew.currentMembers, id: \.self) { memberId in
                GrootView(memberId: memberId, selection: $selection)
            }
        })
        .padding(20)
    }
}

#Preview {
    GrootListView(grew: Grew(
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
