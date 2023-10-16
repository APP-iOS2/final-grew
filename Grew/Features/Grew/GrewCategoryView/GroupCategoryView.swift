//
//  GroupCategoryView.swift
//  CircleRecruitment
//
//  Created by 윤진영 on 2023/09/21.
//

import SwiftUI

struct GroupCategoryView: View {
    @EnvironmentObject var viewModel: GrewViewModel
    @Binding var selection: Selection
    @Binding var showSubCategories: Bool
    private let gridItems: [GridItem] = [
        //        GridItem(.adaptive(minimum: 60))
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("그루의 카테고리를 선택해주세요")
                    .font(.b1_R)
                    .padding(.bottom, 10)
                LazyVGrid(columns: gridItems) {
                    ForEach(viewModel.categoryArray) { category in
                        let isSelected = selection.categoryID == category.id
                        HStack {
                            Button {
                                self.selection.categoryID = category.id
                                self.selection.subCategoryID = nil
                                viewModel.selectedCategoryId = category.id
                                showSubCategories = true
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(isSelected ? Color.Sub : Color.BackgroundGray)
                                    .cornerRadius(12)
                                    .overlay(
                                        Text(category.name)
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
        }
    }
}



#Preview {
    GroupCategoryView(selection: .constant(Selection(categoryID: "", subCategoryID: "")), showSubCategories: .constant(true))
        .environmentObject(GrewViewModel())
}
