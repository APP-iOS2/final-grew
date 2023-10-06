//
//  CategoryButtonView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct CategoryButtonView: View {
    
    @ObservedObject var postViewModel: TempGrewViewModel
    
    private let gridItems: [GridItem] = [
//        GridItem(.adaptive(minimum: 60))
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: gridItems) {
                ForEach(TempHomeCategory.allCases, id: \.rawValue) { category in
                    NavigationLink {
                        
                        CategoryDetailView(grewList: postViewModel.grewList)
                            .navigationTitle(category.rawValue)
                        
                    } label: {
                        VStack {
                            category.image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                             
                            Capsule()
                                .foregroundColor(.clear)
                                .overlay(
                                    Text(category.rawValue)
                                        .font(.body)
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
    CategoryButtonView(postViewModel: TempGrewViewModel())
}
