//
//  ScheduleDetailView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct ScheduleDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var grewViewModel: GrewViewModel
    @EnvironmentObject private var scheduleStore: ScheduleStore
    @State private var hostName: String = ""
    
    let scheduleId: String
    @State private var schedule: Schedule = Schedule(gid: "", scheduleName: "", date: Date(), maximumMember: 0, participants: [], color: "")
    @State private var participants: [User] = []
    
    @State private var isShowingSuccessAlert: Bool = false
    @State private var isShowingFailureAlert: Bool = false
    @State private var isShowingCancelAlert: Bool = false
    @State private var isShowingCancelSuccessAlert: Bool = false
    
    var rows: [GridItem] = Array(repeating: .init(.fixed(44)), count: 1)
    
    private var isScheduleParticipant: Bool {
        if let userId = UserStore.shared.currentUser?.id, schedule.participants.contains(userId) {
            return true
        }
        return false
    }
    
    private var isGrewMember: Bool {
        if let grewMembers =
            grewViewModel.grewList.first(where: { $0.id == schedule.gid })?.currentMembers {
            if let userId = UserStore.shared.currentUser?.id {
                return grewMembers.contains(userId)
            }
        }
        return false
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                VStack {}//: VStack
                .frame(width: UIScreen.screenWidth, height: 120)
                .background(Color.grewMainColor)
                
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            HStack{
                                Text("그루:")
                                    .font(.b3_B)
                                Text(getGrewTitle(gid: schedule.gid))
                                    .font(.b3_R)
                            }//: HStack
                        }//: HStack
                        Text(schedule.scheduleName)
                            .font(.b1_B)
                            .padding(.vertical, 20)
                        Text("날짜, 시간")
                            .font(.b3_B)
                            .padding(.bottom, 5)
                        Text(schedule.grewCellDateString)
                            .font(.b3_R)
                            .padding(.bottom, 20)
                        Text("참여비")
                            .font(.b3_B)
                            .padding(.bottom, 5)
                        Text(schedule.fee ?? "없음")
                            .font(.b3_R)
                            .padding(.bottom)
                        HStack {
                            Text("장소")
                                .font(.b3_B)
                            Spacer()
//                            Text("\(Image(systemName: "map.fill")) 지도 보기")
//                                .font(.b3_R)
                        }
                        .padding(.bottom, 5)
                        Text(schedule.location ?? "")
                            .font(.b3_R)
                            .padding(.bottom)
                        HStack {
                            Text("참여 인원")
                                .font(.b3_B)
                            Spacer()
                            Text("\(schedule.participants.count)/\(schedule.maximumMember) 명 참여 중")
                                .font(.b3_R)
                        }
                        .padding(.bottom, 5)
                    }//: VStack
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, content: {
                            ForEach(participants, id: \.self) { participant in
                                AsyncImage(url: URL(string: participant.userImageURLString ?? "")) { image in
                                    image
                                        .resizable()
                                        .rounded(width: 44, height: 44)
                                } placeholder: {
                                    Image("defaultProfile")
                                        .rounded(width: 44, height: 44)
                                }
                                    
                            }
                        })//: LazyHGrid
                        .padding(.horizontal, 20)
                    }//: ScrollView
                    .frame(height: 44)
                Spacer()
                // 그루에 먼저 참여하고 나서 일정에 참여할 수 있도록!
                Button {
                    if isScheduleParticipant {
                        isShowingCancelAlert = true
                    } else {
                        if let userId = UserStore.shared.currentUser?.id {
                            schedule.participants.append(userId)
                            scheduleStore.updateParticipants(schedule.participants, scheduleId: schedule.id)
                            isShowingSuccessAlert = true
                        }
                    }
                } label: {
                    if !isGrewMember {
                        Text("그루에 가입해주세요!")
                    } else if isScheduleParticipant {
                        Text("일정 취소하기")
                    } else if schedule.participants.count >= schedule.maximumMember {
                        Text("일정 모집 마감")
                    } else {
                        Text("참여하기")
                    }
                }
                .grewButtonModifier(
                    width: UIScreen.screenWidth - 40,
                    height: 44,
                    buttonColor: !isGrewMember || isScheduleParticipant || schedule.participants.count >= schedule.maximumMember ? .DarkGray1 : .grewMainColor,
                    font: .b1_B,
                    fontColor: .white,
                    cornerRadius: 8
                )
                .disabled(!isGrewMember || (!isScheduleParticipant && schedule.participants.count >= schedule.maximumMember))
            }//: VStack
            ProfileCircleImageView(size: 80)
                .offset(x: 20, y: 80)
        }//: ZStack
        .presentationDragIndicator(.visible)
        .onChange(of: schedule, { oldValue, newValue in
            Task {
                await withTaskGroup(of: Void.self) { group in
                    for participantId in schedule.participants {
                        group.addTask {
                            do {
                                if let participant = try await UserStore.shared.findUser(id: participantId) {
                                    DispatchQueue.main.async {
                                        participants.append(participant)
                                    }
                                }
                            } catch {
                                print("Error finding user: \(error)")
                            }
                        }
                    }
                }
            }
        })
        .onAppear {
            if let tempSchedule = scheduleStore.schedules.first(where: { $0.id == scheduleId }) {
                schedule = tempSchedule
            }
        }
        .grewAlert(
            isPresented: $isShowingSuccessAlert,
            title: "일정에 참여되었습니다.",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .Main,
            action: { }
        )
        .grewAlert(
            isPresented: $isShowingCancelAlert,
            title: "일정을 취소하시겠습니까?",
            secondButtonTitle: "닫기",
            secondButtonColor: .LightGray2,
            secondButtonAction: { },
            buttonTitle: "일정 취소",
            buttonColor: .Error,
            action: {
                if let userId = UserStore.shared.currentUser?.id {
                    if let user = schedule.participants.first(where: { $0 == userId }) {
                        if let index = schedule.participants.firstIndex(of: userId) {
                            schedule.participants.remove(at: index)
                            scheduleStore.updateParticipants(schedule.participants, scheduleId: schedule.id)
                            isShowingCancelSuccessAlert = true
                        }
                    }
                }
            }
        )
        .grewAlert(
            isPresented: $isShowingCancelSuccessAlert,
            title: "일정이 취소되었습니다.",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .Main,
            action: { 
                dismiss()
            }
        )
    }
    
    private func getGrewTitle(gid: String) -> String {
        if let grewTitle = grewViewModel.grewList.first(where: { $0.id == gid })?.title {
            return grewTitle
        } else {
            return "그루 이름을 찾을 수 없습니다."
        }
    }
}

#Preview {
    ScheduleDetailView(
        scheduleId: ""

    )
    .environmentObject(GrewViewModel())
}
