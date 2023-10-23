//
//  SavedGrewView.swift
//  Grew
//
//  Created by daye on 2023/10/21.
//

import SwiftUI

struct SavedGrewView: View {

    let grewList: [Grew]
    
    var body: some View {
        VStack {
            if grewList.isEmpty {
                ProfileGrewDataEmptyView(systemImage: "heart", message: "그루를 찜해보세요!", isSavedView: true)
                
            } else {
                ForEach(0 ..< grewList.count, id: \.self) { index in
                    if let grew = grewList[safe: index] {
                        NavigationLink {
                            GrewDetailView(grew: grew)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            
                            GrewCellView(grew: grew)
                                .padding(.trailing, 16)
                                .padding(.bottom, 12)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}

/*
#Preview {

    SavedGrewView(grewList: [Grew(categoryIndex: "123",
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
*/
