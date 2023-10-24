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
    let deviceWidth = UIScreen.main.bounds.size.width
    let quote: String = "\""
    
    var body: some View {
        VStack {
            if !isEmptySchedule().isEmpty {
                yesScheduleView
            } else {
                noScheduleView
            }
        } //: VStack
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
            }
        })
    } //: body
    
    func isEmptySchedule() -> [Schedule] {
        var tempList: [Grew]
        var tempSchedule: [Schedule] = []
        
        // 스케쥴의 그루 아이디, 그루 전체를 둘러봐야함
        if let currentUserId = user?.id {
            
            // 모든 그루에서 현재 아이디가 가입된 그루를 tempList에 넣었고
            tempList = grewViewModel.grewList.filter {
                $0.currentMembers.contains(currentUserId)
            }
            // 가입된 그루를 처음부터 끝까지 하나하나 일정에 같은 아이디가 있다면 넣어라
            for index in 0 ..< tempList.count {
                if let temp = tempList[safe: index] {
                    tempSchedule.append(contentsOf: scheduleStore.schedules.filter {
                        $0.gid == temp.id
                    })
                }
            }
            // gid로 정렬
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
                            
                            // Home - GrewDetail 폴더
                            ScheduleCellView(index: index, schedule: schedules[index])
                                .scaledToFill()
                                .shadow(radius: 6)
                                .padding(.vertical, 10)
                                .onTapGesture {
                                    selectedScheduleId = schedules[index].id
                                    isShowingSheet = true
                                }
                                .scaleEffect(.init(width: scale, height: scale))
                                .animation(.easeOut(duration: 0.5))
//                                .onTapGesture {
//                                    isShowingSheet = true
//                                }
                            
                        } // GeometryReader
                        // 지오메트리 자체에 프레임을 주는 것
                        // 하나 하나 지오메트리를 넣어 크기를준다
                        .frame(width: 140, height: 120)
                        .padding(.trailing, 10)
                    } // ForEach
                    Spacer(minLength: deviceWidth / 2 - 140 / 2 - 20)
                } // HStack
                Spacer()
            } //: ScrollView
            .frame(height: 200)
            .padding(.top, 20)
            Spacer()
        } //: VStack
        .frame(height: 300)
        .background(Color.Main)
        
        
    } //: body
    
    // 뷰의 위치를 기반으로 스케일링 요소를 계산
    // 차이가 특정 임계값 이하인 경우에만 스케일이 조정
    // 이를 통해 뷰의 애니메이션에 활용
    func getScale(proxy: GeometryProxy) -> CGFloat {
        // 애니메이션을 트리거하거나 중앙에 위치시키려는 지점을 정의합니다.
        let middlePoint: CGFloat = deviceWidth / 2
        
        // GeometryProxy를 사용하여 뷰의 프레임을 전역 좌표 공간에서 가져옵니다.
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        // 초기 스케일 요소를 1.0으로 설정합니다.
        var scale: CGFloat = 0.8
        
        // 뷰의 위치가 middlePoint에 가까울 때 애니메이션을 트리거하는 데 사용됩니다.
        // 애니메이션을 트리거하는 데 사용될 x-축 방향의 임계값을 정의합니다.
        let deltaXAnimationThreshold: CGFloat = 80
        
        // 뷰의 현재 위치와 `middlePoint` 사이의 차이를 계산하고 이를 `deltaXAnimationThreshold`의 절반으로 조정한 값의 절대값을 구합니다.
        let diffFromCenter = abs(middlePoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        
        // 차이가 `deltaXAnimationThreshold`보다 작을 경우, 스케일을 조정합니다.
        if diffFromCenter < deltaXAnimationThreshold {
            // 스케일을 1에서 `deltaXAnimationThreshold`와 `diffFromCenter`의 차이를 500으로 나눈 값으로 업데이트합니다.
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
            // 이미지
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
