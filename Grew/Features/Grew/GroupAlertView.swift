//
//  GroupAlert.swift
//  CircleRecruitment
//
//  Created by 윤진영 on 2023/09/22.
//

import ConfettiSwiftUI
import SwiftUI
import ConfettiSwiftUI

struct GroupAlertView: View {

    @EnvironmentObject var viewModel: GrewViewModel
    @State var showsAlert = false
    @State var counter1 = 1
    
    var body: some View {
        ZStack {
                VStack {
                    Text("1차 카테고리: \(viewModel.selectedCategoryName())")
                    Text("2차 카테고리: \(viewModel.selectedSubCategoryName())")
                    Text("모임 이름: \(viewModel.meetingTitle)")
                    Text("성별: \(viewModel.gender.rawValue)")
                    Text("나이: \(viewModel.minimumAge) 세 ~ \(viewModel.maximumAge) 세")
                    Text("인원: \(viewModel.maximumMembers) 명")
                    Text("활동비: \(viewModel.fee) 원")
                }
                .grewAlert(
                    isPresented: $showsAlert,
                    title: "모임생성이 완료되었습니다! 🎉",
                    buttonTitle: "확인",
                    buttonColor: .Main) {
                    }
                ConfettiCannon(counter: $counter1, num: 180, confettis: [.text("❤️"), .text("💙"), .text("💚"), .text("🧡")],
                               openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 250)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        counter1 += 1
                    }
                    showsAlert = true
                }
                .onChange(of: viewModel.selectedCategoryId, { oldValue, newValue in
                    if let category = viewModel.categoryArray.first(where: { $0.id == newValue }) {
                        viewModel.categoryDisplayName = category.name
                    }
                })
                
                .onChange(of: viewModel.selectedSubCategoryId, { oldValue, newValue in
                    if let subCategory = viewModel.categoryArray.first(where: { $0.id == newValue }) {
                        viewModel.categorysubDisplayName = subCategory.name
                    }
                })
            }
        }

}
#Preview {
    GroupAlertView()
        .environmentObject(GrewViewModel())
}



