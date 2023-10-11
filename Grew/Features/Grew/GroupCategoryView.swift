//
//  GroupCategoryView.swift
//  CircleRecruitment
//
//  Created by KangHo Kim on 2023/09/22.
//

import SwiftUI

struct GroupCategoryView: View {
    @EnvironmentObject var viewModel: GrewViewModel
    @State private var selection = Selection()
    @State private var selectedCategoryIndex: Int?
    @State private var selectedSubCategory: Int?
    
//    private let grewExample: Grew = Grew(
//        categoryIndex: "101",
//        title: "테스트 그루1",
//        isOnline: true,
//        gender: Gender.male,
//        minimumAge: 20,
//        maximumAge: 25,
//        maximumMembers: 20,
//        isNeedFee: false)
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("어떤 주제를 선택해 볼까요?")
                    .font(.title2).fontWeight(.semibold)
                    .padding(.bottom, 10)
                Form {
                    ForEach(viewModel.categoryArray) { category in
                        let isSelected = selection.categoryID == category.id
                        VStack {
                            Capsule()
                                .fill(isSelected ? Color.green : Color.white)
                                .stroke(Color.gray, lineWidth: 1.5)
                                .frame(height: 40)
                                .overlay(
                                    Text(category.name)
                                        .font(.body)
                                )
                        }
                        .onTapGesture {
                            self.selection.categoryID = category.id
                            self.selection.subCategoryID = nil
                            viewModel.selectedCategoryId = category.id 
                        }
                        
                        if isSelected {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(category.subCategories) { subCategory in
                                        let isSelected = selection.subCategoryID == subCategory.id
                                        HStack {
                                            
                                            Capsule()
                                                .fill(isSelected ? Color.green : Color.white)
                                                .stroke(Color.gray, lineWidth: 1.5)
                                                .frame(width: 70,height: 40)
                                                .overlay(
                                                    Text(subCategory.name)
                                                        .font(.body)
                                                )
                                        }
                                        .onTapGesture {
                                            self.selection.subCategoryID = subCategory.id
                                            viewModel.selectedSubCategoryId = subCategory.id
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }//: VStack
            .padding()
        }//: ScrollView
    }//: body
}

#Preview {
    GroupCategoryView()
}
