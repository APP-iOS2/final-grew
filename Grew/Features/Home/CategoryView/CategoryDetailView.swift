//
//  CategoryDetailView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct CategoryDetailView: View {
    
    @State private var selection: Selection = Selection()
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
                // 카테고리 리스트를 새로 만들어야함 기존것을 쓰면 앞에 순위가 붙음
                CategoryListView(grewList: filterList)
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
                    selection.subCategoryID = nil
                } label: {
                    Text("전체")
                        .foregroundStyle(selection.subCategoryID == nil ? Color.white : Color.Black)
                        .font(.b3_B)
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                }
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .foregroundStyle(selection.subCategoryID == nil ? Color.Sub : Color.BackgroundGray)
                )
                .padding(.trailing, 5)
                
                ForEach(secondCategory) { category in
                    let isSelected = selection.subCategoryID == category.id
                    Button {
                        filterList = grewList.filter {
                            $0.categorysubIndex == category.id
                        }
                        selection.subCategoryID = category.id
                        
                    } label: {
                        Text("\(category.name)")
                            .foregroundStyle(isSelected && selection.subCategoryID != nil ? Color.white : Color.Black)
                            .font(.b3_B)
                            .padding(.vertical, 12)
                            .padding(.horizontal)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 22)
                            .foregroundStyle(isSelected && selection.subCategoryID != nil ? Color.Sub : Color.BackgroundGray)
                    )
                    .padding(.trailing, 5)
                }
            } //: HStack
            .padding(.horizontal)
            
        } //: ScrollView
        .scrollIndicators(.hidden)
//        .padding(.horizontal, 12)
    }
    
    
}

#Preview {
    CategoryDetailView(grewList: [], secondCategory: [])
//        .environmentObject(GrewViewModel())
}
