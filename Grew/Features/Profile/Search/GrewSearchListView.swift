//
//  GrewSearchListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/20.
//

import SwiftUI

struct GrewSearchListView: View {
    
    let grewList: [Grew]
    
    var body: some View {
        VStack {
            
            ForEach(0 ..< grewList.count, id: \.self) { index in
                NavigationLink {
                    GrewDetailView(grew: grewList[index])
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

#Preview {
    GrewSearchListView(grewList: [Grew(categoryIndex: "123",
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
