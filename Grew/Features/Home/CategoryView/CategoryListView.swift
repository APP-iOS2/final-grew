//
//  CategoryListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/19.
//

import SwiftUI

struct CategoryListView: View {
    
    let grewList: [Grew]
    
    var body: some View {
        VStack {
            if grewList.count < 1 {
                Group {
                    Text("해당 카테고리에는 그루가 없습니다.")
                    Text("새로운 그루를 생성해보세요!")
                }
                .font(.b1_B)
                .foregroundStyle(Color.Black)
                
            } else {
                ForEach(0 ..< grewList.count, id: \.self) { index in
                    NavigationLink {
                        GrewDetailView(grew: grewList[index])
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        
                        GrewCellView(grew: grewList[index])
                            .padding(.trailing, 16)
                            .padding(.bottom, 12)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryListView(grewList: [Grew(categoryIndex: "123",
    categorysubIndex: "456",
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
    fee: 0),
    Grew(categoryIndex: "123",
    categorysubIndex: "456",
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
    fee: 0)])
}
