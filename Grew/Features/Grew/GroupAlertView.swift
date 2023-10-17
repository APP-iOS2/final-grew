//
//  GroupAlert.swift
//  CircleRecruitment
//
//  Created by 윤진영 on 2023/09/22.
//

import ConfettiSwiftUI
import SwiftUI

struct GroupAlertView: View {
    
    @EnvironmentObject var viewModel: GrewViewModel
    @State var showsAlert = false
    @State var counter1 = 1
    @Environment (\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                Text("")
            }
            .grewAlert(
                isPresented: $showsAlert,
                title: "모임생성이 완료되었습니다! 🎉",
                buttonTitle: "확인",
                buttonColor: .Main) {
                    dismiss()
            }
            ConfettiCannon(counter: $counter1, 
                num: 180,
                confettis: [.text("❤️"), .text("💙"), .text("💚"), .text("🧡")],
                openingAngle: Angle(degrees: 0),
                closingAngle: Angle(degrees: 360),
                radius: 250)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    counter1 += 1
                }
                showsAlert = true
            }
            
        }
    }
    
}
#Preview {
    GroupAlertView()
        .environmentObject(GrewViewModel())
}




/*
 VStack {
 Text("1차 카테고리: \(viewModel.selectedCategoryName())")
 Text("2차 카테고리: \(viewModel.selectedSubCategoryName())")
 Text("모임 이름: \(viewModel.meetingTitle)")
 Text("성별: \(viewModel.gender.rawValue)")
 Text("나이: \(viewModel.minimumAge) 세 ~ \(viewModel.maximumAge) 세")
 Text("인원: \(viewModel.maximumMembers) 명")
 Text("활동비: \(viewModel.fee) 원")
 }
 
 // 변경됨을 감지 -> viewModel.selectedCategoryId를 기반으로 변경된 값(= 선택된 값)을 newValue 에 전달
 .onChange(of: viewModel.selectedCategoryId, { oldValue, newValue in
 // viewModel.categoryArray 배열에서 해당 카테고리를 찾아서
 // viewModel.categoryDisplayName 에 할당
 if let category = viewModel.categoryArray.first(where: { $0.id == newValue }) {
 viewModel.categoryDisplayName = category.name
 }
 })
 
 .onChange(of: viewModel.selectedSubCategoryId, { oldValue, newValue in
 if let subCategory = viewModel.categoryArray.first(where: { $0.id == newValue }) {
 viewModel.categorysubDisplayName = subCategory.name
 }
 })
 */
