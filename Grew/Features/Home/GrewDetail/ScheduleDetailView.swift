//
//  ScheduleDetailView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct ScheduleDetailView: View {
    @EnvironmentObject private var grewViewModel: GrewViewModel
    @State private var hostName: String = ""
    let schedule: Schedule?
    private var tempSchedule: Schedule {
        if let schedule {
            return schedule
        } else {
            return Schedule(gid: "", scheduleName: "", date: Date(), maximumMember: 1, participants: [], color: "")
        }
    }

    var rows: [GridItem] = Array(repeating: .init(.fixed(44)), count: 1)
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                VStack {}//: VStack
                .frame(width: UIScreen.screenWidth, height: 120)
                .background(Color.grewMainColor)
                
//                if let schedule {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            HStack{
                                Text("그루:")
                                    .font(.b3_B)
                                Text(getGrewTitle(gid: tempSchedule.gid))
                                    .font(.b3_R)
                            }//: HStack
                        }//: HStack
                        Text(tempSchedule.scheduleName)
                            .font(.b1_B)
                            .padding(.vertical, 20)
                        Text("날짜, 시간")
                            .font(.b3_B)
                            .padding(.bottom, 5)
                        Text(tempSchedule.grewCellDateString)
                            .font(.b3_R)
                            .padding(.bottom, 20)
                        Text("참여비")
                            .font(.b3_B)
                            .padding(.bottom, 5)
                        Text(tempSchedule.fee ?? "없음")
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
                        Text(tempSchedule.location ?? "")
                            .font(.b3_R)
                            .padding(.bottom)
                        HStack {
                            Text("참여 인원")
                                .font(.b3_B)
                            Spacer()
                            Text("\(tempSchedule.participants.count)/\(tempSchedule.maximumMember) 명 참여 중")
                                .font(.b3_R)
                        }
                        .padding(.bottom, 5)
                    }//: VStack
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, content: {
                            ForEach(0...10, id: \.self) { _ in
                                Image(.defaultProfile)
                                    .rounded(width: 44, height: 44)
                            }
                        })//: LazyHGrid
                        .padding(.horizontal, 20)
                    }//: ScrollView
                    .frame(height: 44)
//                } else {
//                    Text("Not Found")
//                }
                Spacer()
                Button {
                    
                } label: {
                    Text("참여하기")
                }
                .grewButtonModifier(width: UIScreen.screenWidth - 40, height: 44, buttonColor: .grewMainColor, font: .b1_B, fontColor: .white, cornerRadius: 8)
            }//: VStack
            ProfileCircleImageView(size: 80)
                .offset(x: 20, y: 80)
        }//: ZStack
        .onAppear {
            print(schedule)
        }
        .presentationDragIndicator(.visible)
    }
    
//    private func getHostName(gid: String) -> String {
//        var hostName = "뭐지"
//        grewViewModel.getHost(gid: gid) { user in
//            hostName = user?.nickName ?? "이름 없음"
//            print(user)
//            print(hostName)
//        }
//        return hostName
//    }
    
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
        schedule: Schedule(
            id: "aa",
            gid: "",
            scheduleName: "5시 농구",
            date: Date(),
            maximumMember: 10,
            participants: ["", ""],
            fee: nil,
            location: nil,
            latitude: nil,
            longitude: nil,
            color: "color"
        )
    )
    .environmentObject(GrewViewModel())
}
