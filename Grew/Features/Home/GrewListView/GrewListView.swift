//
//  PostListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct GrewListView: View {
    
    let grewList: [Grew]
    @EnvironmentObject var router: HomeRouter
    
    var body: some View {
        VStack {
            ForEach(0 ..< grewList.count, id: \.self) { index in
                // 그루 디테일 뷰
                Button {
//                    GrewDetailView(grew: grewList[index])
                    router.homeNavigate(to: .grewDetail(grew: grewList[index]))
                } label: {
                    HStack {
                        
                        VStack {
                            
                            if index < 3 {
                                Image(indexToImage(rank: index))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 44, height: 44)
                                    .padding(.vertical)
                            } else {
                                
                                Text("\(index + 1)")
                                    .font(.b1_B)
                                    .foregroundStyle(Color.black)
                                    .padding()
                                
                            }
                            
                        }
                        .padding(.leading, 16)
                        
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

func indexToImage(rank: Int) -> String {
    switch rank {
    case 0:
        return "first"
    case 1:
        return "second"
    case 2:
        return "third"
    default:
        return ""
    }
}

#Preview {
    GrewListView(grewList: [Grew(categoryIndex: "123",
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
