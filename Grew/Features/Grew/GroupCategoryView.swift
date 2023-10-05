//
//  GroupCategoryView.swift
//  CircleRecruitment
//
//  Created by KangHo Kim on 2023/09/22.
//

import SwiftUI

struct GroupCategoryView: View {
    @StateObject var grewViewModel = GrewViewModel()
    private let grewExample: Grew = Grew(category: "0202",
                                         title: "배고파용",
                                         description: "어쩌구",
                                         isOnline: false,
                                         location: "서울특별시 동대문구 회기동",
                                         gender: .any,
                                         minimumAge: 22,
                                         maximumAge: 29,
                                         maximumMembers: 20,
                                         currentMembers: [],
                                         isNeedFee: true,
                                         fee: 16000)
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                Text("어떤 주제를 선택해 볼까요?")
                    .font(.title2).fontWeight(.semibold)
                    .padding(.bottom, 10)
                Spacer()
                Button(action: {
                    grewViewModel.addGrew(grewExample)
                }, label: {
                    Text("가랏 가라 데이터")
                })
                /*LazyVGrid(columns: gridItems) {
                 ForEach(0..<groupInfo.myCategories.count, id: \.self) { index in
                 let category = myCategories[index]
                 let categoryName = category["title"] as? String ?? ""
                 let isSelected = selectedFirstCategory == index
                 
                 VStack {
                 Capsule()
                 .fill(isSelected ? Color.green : Color.white)
                 .stroke(Color.gray, lineWidth: 1.5)
                 .frame(height: 40)
                 .overlay(
                 Text(myCategories[index]["title"] as? String ?? "")
                 .font(.body)
                 )
                 }
                 .onTapGesture {
                 self.selectedFirstCategory = index
                 }
                 }
                 }*/
                Spacer()
                Divider()
                Spacer()
                /*LazyVGrid(columns: gridItems) {
                 ForEach(0..<secondCategories.count, id: \.self) { index in
                 let isSelectedSecond = selectedSecondCategory == index
                 VStack {
                 Capsule()
                 .fill(isSelectedSecond ? Color.green : Color.white)
                 .stroke(Color.gray, lineWidth: 1.5)
                 .frame(height: 40)
                 .overlay(
                 Text(secondCategories[index])
                 .font(.body)
                 )
                 }
                 .onTapGesture {
                 self.selectedSecondCategory = index
                 
                 }
                 }
                 }*/
            }//: VStack
            .padding()
        }//: ScrollView
    }//: body
}

#Preview {
    GroupCategoryView()
}
