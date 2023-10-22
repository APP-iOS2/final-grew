//
//  MyGroupScheduleView.swift
//  Grew
//
//  Created by daye on 2023/10/21.
//

import SwiftUI

struct MyGroupScheduleView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack{
            //ProfileGrewDataEmptyView(systemImage: "calendar", message: "그루 일정이 없어요.")


            LazyVGrid(columns: columns) {
                ForEach((0..<10), id: \.self) { i in
                        // Home - GrewDetail 폴더
                    ScheduleCellView(index: i, 
                                     schedule: Schedule(
                                        gid: "750CFF84-E36B-4C31-A795-A83FF4A95CA4",
                                        scheduleName: "엽떡 탐방",
                                        date: Date(),
                                        maximumMember: 2,
                                        participants: [],
                                        color: "7CDCAE"))
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .shadow(radius: 2)
                            .padding(.bottom, 30)

                    }

                }
        }.padding(.bottom, 30)

    }
}

#Preview {
    NavigationStack {
        MyGroupScheduleView()
    }
}
