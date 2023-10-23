//
//  MyGroupScheduleView.swift
//  Grew
//
//  Created by daye on 2023/10/21.
//

import SwiftUI

struct MyGroupScheduleView: View {
    
    @State private var isShowingSheet: Bool = false
    @State private var selectedScheduleId: String = ""
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let schedules: [Schedule]
    
    var body: some View {
        
        if schedules.isEmpty{
            ProfileGrewDataEmptyView(systemImage: "calendar", message: "그루 일정이 없어요.")
        } else{
            VStack{
                LazyVGrid(columns: columns) {
                    
                    ForEach(Array(schedules.enumerated()), id: \.element.id) { index, schedule in
                        ScheduleCellView(index: index, schedule: schedule)
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .shadow(radius: 2)
                            .padding(.bottom, 30)
                            .onTapGesture {
                                isShowingSheet = true
                                selectedScheduleId = schedule.id
                            }
                    }
                }
            }.sheet(isPresented: $isShowingSheet, content: {
               ScheduleDetailView(scheduleId: selectedScheduleId)
            })
            .padding(.bottom, 30)
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        MyGroupScheduleView(schedules: [Schedule]())
    }
}
