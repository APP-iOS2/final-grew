//
//  CategoryDetailView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct CategoryDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var grewViewModel: GrewViewModel
    @State private var selection: Selection = Selection()
    @State private var grewList: [Grew] = []
//    let secondCategory: [SubCategory]
    let category: GrewCategory
    
    // 선택된 카테고리
    
    // 선택되어 필터링 된 리스트
    @State var filterList: [Grew] = []
    
    var body: some View {
        VStack {
            // 서브뷰로 만들어 넣기 (extention)
            categoryList
            .padding(.vertical)
            
            ScrollView {
                // 카테고리 리스트를 새로 만들어야함 기존것을 쓰면 앞에 순위가 붙음
                CategoryListView(category: category)
            }            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 18))
                            .foregroundStyle(Color.black)
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            fetchGrewList()
        }
        .onReceive(grewViewModel.grewList.publisher, perform: { _ in
            fetchGrewList()
        })
        
    }
    
    private func fetchGrewList() {
        grewList = grewViewModel.grewList.filter {
            $0.categoryIndex == category.id
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
                
                ForEach(category.subCategories) { category in
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
    NavigationStack {
        CategoryDetailView(
            category: GrewCategory(
                id: "",
                name: "",
                imageString: "",
                subCategories: []
            )
        )
    }
        .environmentObject(GrewViewModel())
}
