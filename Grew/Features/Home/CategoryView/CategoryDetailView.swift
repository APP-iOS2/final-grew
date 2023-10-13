//
//  CategoryDetailView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct CategoryDetailView: View {
    
    let grewList: [Grew]
    let secondCategory: [SubCategory]
    
    // 선택된 카테고리
    
    // 선택되어 필터링 된 리스트
    @State var filterList: [Grew] = []
    
    var body: some View {
        VStack {
            // 서브뷰로 만들어 넣기 (extention)
            categoryList
            .padding(.bottom, 12)
            
            ScrollView {
                GrewListView(grewList: filterList)
            }
        }
        .onAppear {
            filterList = grewList
        }
    }
}

// 카테고리 리스트 정의
extension CategoryDetailView {
    
    var categoryList: some View {
        ScrollView(.horizontal) {
            HStack {
                
                Button {
                    filterList = grewList
                } label: {
                    Text("전체")
                        .foregroundStyle(Color.white)
                        .font(.c1_R)
                        .padding(5)
                }
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(Color(red: 37, green: 197, blue: 120))
                )
                
                ForEach(secondCategory) { category in
                    
                    Button {
                        filterList = grewList.filter {
                            $0.categorysubIndex == category.id
                        }
                    } label: {
                        Text("\(category.name)")
                            .foregroundStyle(Color.white)
                            .font(.c1_R)
                            .padding(5)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(Color(red: 37, green: 197, blue: 120))
                    )
                }
            }
            
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 12)
    }
    
    
}

#Preview {
    CategoryDetailView(grewList: [], secondCategory: [])
}
