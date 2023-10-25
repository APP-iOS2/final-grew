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
                secondButtonTitle: nil,
                secondButtonColor: nil,
                secondButtonAction: nil,
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
