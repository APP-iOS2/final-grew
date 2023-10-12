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
    @State private var showsAlert = false
    @State var counter1 = 1
    
    var body: some View {
        VStack {
            Text("1차 카테고리: \(viewModel.selectedCategoryName())")
            Text("2차 카테고리: \(viewModel.selectedSubCategoryName())")
            Text("모임 이름: \(viewModel.meetingTitle)")
            Text("성별: \(viewModel.gender.rawValue)")
            Text("나이: \(viewModel.minimumAge) ~ \(viewModel.maximumAge)")
            Text("인원: \(viewModel.maximumMembers) 명")
            Text("활동비: \(viewModel.fee) 원")
        }.onChange(of: viewModel.selectedCategoryId, { oldValue, newValue in
            if let category = viewModel.categoryArray.first(where: { $0.id == newValue }) {
                viewModel.categoryDisplayName = category.name
            }
        })
        
//        .alert(isPresented: $showsAlert) {
//            Alert(title: Text("모임생성이 완료되었습니다! 🎉"),
//                  message: Text(""),
//                  dismissButton: .default(Text("확인")))
//        }
        
        .grewAlert(
            isPresented: $showsAlert,
            title: "모임생성이 완료되었습니다! 🎉",
            buttonTitle: "확인",
            buttonColor: .Main) {
            //
        }
        
        .onChange(of: viewModel.selectedSubCategoryId, { oldValue, newValue in
            if let subCategory = viewModel.categoryArray.first(where: { $0.id == newValue }) {
                viewModel.categorysubDisplayName = subCategory.name
            }
        })
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              counter1 += 1
          }
            showsAlert = true
        }
        ConfettiCannon(counter: $counter1, num:180,confettis: [.text("❤️"), .text("💙"), .text("💚"), .text("🧡")], openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 250)
            
    }
}

#Preview {
    GroupAlertView()
        .environmentObject(GrewViewModel())
}

/*
 .grewAlert(
     isPresented: $showsAlert,
     title: "모임생성이 완료되었습니다! 🎉",
     buttonTitle: "확인",
     buttonColor: .Main) {
     //
 }
 */
 /*
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
.onAppear {
  showsAlert = true
  DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      counter1 += 1
      
  }
}
  ConfettiCannon(counter: $counter1, num:180,confettis: [.text("❤️"), .text("💙"), .text("💚"), .text("🧡")], openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 250)
//        ConfettiCannon(counter: $counter1, num:180, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 300)
.alert(isPresented: $showsAlert) {
  Alert(title: Text("모임생성이 완료되었습니다."),
        message: Text(""),
        dismissButton: .default(Text("완료")))
}
  */
  
