//
//  PostView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct GrewCellView: View {
    
    let grew: Grew
    /// 즐겨찾기? 버튼이 유저, Grew 각각 들어가야함
    @EnvironmentObject var grewViewModel: GrewViewModel
    
    var body: some View {
        
        HStack {
            
            GrewImageView(image: grew.imageURL)
                .padding(.bottom, 13)
                .padding(.leading, 13)
            
            VStack(alignment: .leading) {
                
                Text(grewViewModel.subCategoryName(grew.categoryIndex, grew.categorysubIndex))
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
                    .padding(.bottom, 3)
                    .background(Color.BackgroundGray)
                    .cornerRadius(12)
                    .foregroundColor(.DarkGray2)
                    .font(.c1_B)
                
                Text(grew.title)
                    .font(.b2_B)
                    .foregroundStyle(Color.black)
                
                Spacer()
                HStack {
                    
                    Spacer()
                    
                    Group {
                        Image(systemName: "person.2.fill")
                            .padding(.trailing, -5)
                            .font(.c2_B)
                            .foregroundStyle(Color.DarkGray1)
                        HStack {
                            Text("\(grew.currentMembers.count)")
                            Text("/")
                                .padding(.horizontal, -5)
                            Text("\(grew.maximumMembers)")
                                .padding(.leading, -5)
                        }
                        .font(.c2_B)
                        .foregroundStyle(Color.DarkGray1)
                    }
                }
            }
            .padding(.leading, 10)
            
            .frame(height: 110)
            
            Spacer()
        }
        .padding(10)
        .fontWeight(.heavy)
        .frame(maxWidth: .infinity)
        .frame(height: 130)
    }
}

#Preview {
    GrewCellView(grew: Grew(
        categoryIndex: "123",
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
        fee: 0))
    .environmentObject(GrewViewModel())
}
