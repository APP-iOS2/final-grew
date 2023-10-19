//
//  ScheduleListView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct ScheduleListView: View {
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("+ 새 일정 만들기")
            }
            .grewButtonModifier(width: UIScreen.screenWidth - 40, height: 44, buttonColor: .clear, font: .b1_B, fontColor: .DarkGray1, cornerRadius: 8)
            .border(Color.DarkGray1, width: 4)
            .cornerRadius(8)
            Divider()
                .padding(.vertical, 10)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach((0...19), id: \.self) { _ in
                        ScheduleCellView()
                    }
                }
            }
        }//: VStack
        .padding(20)
    }
}

#Preview {
    ScheduleListView()
}
