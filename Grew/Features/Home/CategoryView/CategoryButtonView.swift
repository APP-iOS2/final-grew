//
//  CategoryButtonView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct CategoryButtonView: View {
    
    @EnvironmentObject var grewViewModel: GrewViewModel
    
    private let gridItems: [GridItem] = [
//        GridItem(.adaptive(minimum: 60))
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("새로운 그루를 찾아보세요!")
                .font(.b1_B)
                .foregroundStyle(Color.black)
                .padding(.top, 40)
                .padding(.bottom, 25)
                .padding(.horizontal)
            
            LazyVGrid(columns: gridItems) {
                ForEach(grewViewModel.categoryArray) { category in
                    
                    NavigationLink {
                        CategoryDetailView(grewList: grewViewModel.grewList.filter {
                            $0.categoryIndex == category.id
                        }, secondCategory: category.subCategories)
                            .navigationTitle(category.name)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarBackButtonHidden(true)
                        
                    } label: {
                        VStack {
                            Image("\(category.imageString)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                             
                            Capsule()
                                .foregroundColor(.clear)
                                .overlay(
                                    Text(category.name)
                                        .font(.c1_R)
                                        .minimumScaleFactor(0.9)
                                        .foregroundStyle(.black)
                                )
                                
                        }
                        .foregroundColor(.black)
                        .padding(.bottom, 15)
                        .background(.white)
                        .cornerRadius(12)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color.gray, lineWidth: 1.5)
//                        )
                    }
                }
                .padding(.horizontal)
            } //: LazyGrid
            .padding(.bottom, 25)
            // 배너
            PagingBannerView()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(height: 100)
                .padding(.horizontal)
        }
    }
}

#Preview {
    CategoryButtonView()
        .environmentObject(GrewViewModel())
}
