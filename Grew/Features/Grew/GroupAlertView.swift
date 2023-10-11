//
//  GroupAlert.swift
//  CircleRecruitment
//
//  Created by 윤진영 on 2023/09/22.
//

import SwiftUI
import ConfettiSwiftUI

struct GroupAlertView: View {
    @State private var showsAlert = false
    @State var counter1 = 1
    
    var body: some View {
        Text("모임 생성 완료!")
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
    }
}
#Preview {
    GroupAlertView()
}
