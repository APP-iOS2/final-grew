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
        VStack {
            LazyVGrid(columns: gridItems) {
                ForEach(grewViewModel.categoryArray) { category in
                    
                    NavigationLink {
                        CategoryDetailView(grewList: grewViewModel.grewList.filter {
                            $0.categoryIndex == category.id
                        }, secondCategory: category.subCategories)
                            .navigationTitle(category.name)
                        
                    } label: {
                        VStack {
                            Image("\(category.imageString)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                             
                            Capsule()
                                .foregroundColor(.clear)
                                .overlay(
                                    Text(category.name)
                                        .font(.c1_R)
                                        .foregroundStyle(.black)
                                )
                                
                        }
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 1.5)
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryButtonView()
        .environmentObject(GrewViewModel())
}
