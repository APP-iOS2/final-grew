//
//  CategoryButtonView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct CategoryButtonView: View {
    
    @EnvironmentObject var grewViewModel: GrewViewModel
    @EnvironmentObject var router: HomeRouter
    
    private let gridItems: [GridItem] = [
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
                    
                    Button {
                        router.homeNavigate(to: .category(category: category))
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
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 25)
            
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
