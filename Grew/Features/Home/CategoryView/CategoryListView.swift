//
//  CategoryListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/19.
//

import SwiftUI

struct CategoryListView: View {
    
    @EnvironmentObject private var grewViewModel: GrewViewModel
//    let grewList: [Grew]
    @State private var grewList: [Grew] = []
    @State private var filterList: [Grew] = []
    
    let category: GrewCategory
    let subCategory: SubCategory?
    
    var body: some View {
        VStack {
            if filterList.isEmpty {
                Group {
                    Text("해당 카테고리에는 그루가 없습니다.")
                    Text("새로운 그루를 생성해보세요!")
                }
                .font(.b1_B)
                .foregroundStyle(Color.Black)
                
            } else {
                ForEach(0 ..< filterList.count, id: \.self) { index in
                    if let grew = filterList[safe: index] {
                        NavigationLink {
                            GrewDetailView(grew: grew)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            
                            GrewCellView(grew: grew)
                                .padding(.trailing, 16)
                                .padding(.bottom, 12)
                                .foregroundColor(.black)
                        }
                    }
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
        grewViewModel.fetchGrew()
        grewList = grewViewModel.grewList.filter {
            $0.categoryIndex == category.id
        }
        if let subCategory {
            filterList = grewList.filter {
                $0.categorysubIndex == subCategory.id
            }
        } else {
            filterList = grewList
        }
    }
}

#Preview {
//    CategoryListView(grewList: [Grew(categoryIndex: "123",
//    categorysubIndex: "456",
//    title: "123",
//    description: "123",
//    imageURL: "https://image.newsis.com/2023/05/25/NISI20230525_0001274814_web.jpg",
//    isOnline: true,
//    location: "123",
//    gender: .male,
//    minimumAge: 12,
//    maximumAge: 12,
//    maximumMembers: 12,
//    currentMembers: ["1", "2"],
//    isNeedFee: true,
//    fee: 0),
//    Grew(categoryIndex: "123",
//    categorysubIndex: "456",
//    title: "123",
//    description: "123",
//    imageURL: "https://image.newsis.com/2023/05/25/NISI20230525_0001274814_web.jpg",
//    isOnline: true,
//    location: "123",
//    gender: .male,
//    minimumAge: 12,
//    maximumAge: 12,
//    maximumMembers: 12,
//    currentMembers: ["1", "2"],
//    isNeedFee: true,
//    fee: 0)])
    CategoryListView(
        category: GrewCategory(
            id: "",
            name: "",
            imageString: "",
            subCategories: []
        ),
        subCategory: SubCategory(
            id: "",
            name: ""
        )
    )
}
