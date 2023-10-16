//
//  GroupSubCategoryView.swift
//  Grew
//
//  Created by 윤진영 on 10/16/23.
//

import SwiftUI

struct GroupSubCategoryView: View {
    @EnvironmentObject var viewModel: GrewViewModel
    @Binding var selection: Selection
    @State private var showSubCategories = false
    private let gridItems: [GridItem] = [
        //        GridItem(.adaptive(minimum: 60))
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            if let selectedCategory = viewModel.categoryArray.first(where: { $0.id == selection.categoryID }) {
                VStack(alignment: .leading) {
                    Text("상세 카테고리를 선택해주세요")
                        .font(.b1_R)
                        .padding(.bottom, 10)
                    LazyVGrid(columns: gridItems) {
                        ForEach(selectedCategory.subCategories) { subcategory in
                            let isSelected = selection.subCategoryID == subcategory.id
                            
                            HStack {
                                Button {
                                    self.selection.subCategoryID = subcategory.id
                                    viewModel.selectedSubCategoryId = subcategory.id
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(isSelected ? Color.Sub : Color.BackgroundGray)
                                        .cornerRadius(12)
                                        .overlay(
                                            Text(subcategory.name)
                                                .font(.b1_B)
                                                .foregroundStyle(isSelected ? Color.white : Color.black)
                                        )
                                }
                                .frame(height: 30)
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                            }
                        }
                    }
                }.padding()
                    .animationModifier(isAnimating: showSubCategories, delay: 0)
                    .onAppear {
                        showSubCategories = true
                    }
            }
        }
    }
}

#Preview {
    GroupSubCategoryView(selection: .constant(Selection(categoryID: "", subCategoryID: "")))
        .environmentObject(GrewViewModel())
}
