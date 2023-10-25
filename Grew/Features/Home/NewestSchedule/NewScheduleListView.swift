//
//  NewestScheduleListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/18.
//

import SwiftUI

/// 최신 일정 뷰
struct NewestScheduleListView: View {
    @EnvironmentObject var grewViewModel: GrewViewModel
    @EnvironmentObject var scheduleStore: ScheduleStore
    
    @State private var isShowingSheet: Bool = false
    @State private var selectedScheduleId: String = ""
    @State private var scheduleId: String = ""
    @State private var user: User? = UserStore.shared.currentUser
    @State private var isLoading: Bool = true
    let deviceWidth = UIScreen.main.bounds.size.width
    let quote: String = "\""
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                if !isEmptySchedule().isEmpty {
                    yesScheduleView
                } else {
                    noScheduleView
                }
            }
        }
        .frame(height: 300)
        .background(Color.Main)
        .sheet(isPresented: $isShowingSheet, content: {
            ScheduleDetailView(scheduleId: scheduleId)
        })
        .onChange(of: selectedScheduleId) { oldValue, newValue in
            scheduleId = selectedScheduleId
        }
        .onReceive(AuthStore.shared.currentUser.publisher, perform: { userPublisher in
            Task {
                try await UserStore.shared.loadUserData()
                user = UserStore.shared.currentUser
                isLoading = false
            }
        })
    }
    
    func isEmptySchedule() -> [Schedule] {
        var tempList: [Grew]
        var tempSchedule: [Schedule] = []
        
        if let currentUserId = user?.id {
            
            tempList = grewViewModel.grewList.filter {
                $0.currentMembers.contains(currentUserId)
            }
            for index in 0 ..< tempList.count {
                if let temp = tempList[safe: index] {
                    tempSchedule.append(contentsOf: scheduleStore.schedules.filter {
                        $0.gid == temp.id
                    })
                }
            }
            tempSchedule.sort { (schedule1, schedule2) in
                return schedule1.date < schedule2.date
                
            }
            return tempSchedule
        }
        return []
    }
}

extension NewestScheduleListView {
    
    var yesScheduleView: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("가입한 그루에")
                        .font(.h2_B)
                    Spacer()
                }
                HStack {
                    Text("참여하지 않은 새로운 일정이 있어요!")
                        .font(.h2_B)
                    Spacer()
                }
            }
            .foregroundStyle(.white)
            .padding(.top, 40)
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                let schedules = isEmptySchedule()
                HStack(spacing: 20) {
                    Spacer(minLength: deviceWidth / 2 - 140 / 2 - 20)

                    ForEach(0 ..< schedules.count) { index in
                        GeometryReader { proxy in
                            let scale = getScale(proxy: proxy)
                            
                            if let schedule = schedules[safe: index] {
                                ScheduleCellView(index: index, schedule: schedule)
                                    .scaledToFill()
                                    .shadow(radius: 6)
                                    .padding(.vertical, 10)
                                    .onTapGesture {
                                        selectedScheduleId = schedule.id
                                        isShowingSheet = true
                                    }
                                    .scaleEffect(.init(width: scale, height: scale))
                                    .animation(.easeOut(duration: 0.5))
                            }
                        }
                        .frame(width: 140, height: 120)
                        .padding(.trailing, 10)
                    }
                    Spacer(minLength: deviceWidth / 2 - 140 / 2 - 20)
                }
                Spacer()
            }
            .frame(height: 200)
            .padding(.top, 20)
            Spacer()
        }
        .frame(height: 300)
        .background(Color.Main)
        
        
    }
    func getScale(proxy: GeometryProxy) -> CGFloat {
        let middlePoint: CGFloat = deviceWidth / 2
        
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 0.8
        
        let deltaXAnimationThreshold: CGFloat = 80
        
        let diffFromCenter = abs(middlePoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 0.6 + 0.4
        }
        
        return scale
    }
    
    var noScheduleView: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("새로운 일정이 아직 없어요...")
                    .font(.h2_B)
                    .padding(.bottom, 5)
                Text("직접 그루를 생성하고 일정을 만들어봐요!")
                    .font(.h2_B)
            }
            .foregroundStyle(.white)
            .padding(.top, 40)
            Spacer()
            Image("newest")
                .offset(y: 30)
        }
    }
}




#Preview {
    NewestScheduleListView()
        .environmentObject(GrewViewModel())
        .environmentObject(ScheduleStore())
}
