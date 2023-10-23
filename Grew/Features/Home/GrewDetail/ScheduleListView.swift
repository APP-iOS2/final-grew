//
//  ScheduleListView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct ScheduleListView: View {
    
    @EnvironmentObject var scheduleStore: ScheduleStore
    @State private var isShowingScheduleSheet: Bool = false
    @State private var isShowingEditSheet: Bool = false
    @State var detentHeight: CGFloat = 0
    @State private var selectedScheduleId: String = ""
    
    let grew: Grew
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    private var isGrewHost: Bool {
        if let userId = UserStore.shared.currentUser?.id, userId == grew.hostID {
            return true
        }
        return false
    }
    
    var body: some View {
        VStack{
            if isGrewHost {
                NavigationLink {
                    CreateScheduleMainView(gid: grew.id)
                        .padding(3)
                } label: {
                    Image(systemName: "plus")
                    Text("새 일정 만들기")
                }
                .grewButtonModifier(width: UIScreen.screenWidth - 40, height: 44, buttonColor: .clear, font: .b1_B, fontColor: .DarkGray1, cornerRadius: 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.DarkGray1)
                )
                Divider()
                    .padding(.vertical, 10)
            }
            ScrollView{
                let schedules = getSchedules()
                if !schedules.isEmpty {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0 ..< schedules.count) { index in
                            ScheduleCellView(index: index, schedule: schedules[index])
                                .onTapGesture(perform: {
                                    selectedScheduleId = schedules[index].id
                                    isShowingEditSheet = false
                                    isShowingScheduleSheet = true
                                })
                                .onLongPressGesture {
                                    isShowingScheduleSheet = false
                                    isShowingEditSheet = true
                                }
                                .padding(.bottom, 5)
                        }
                    }
                } else {
                    ProfileGrewDataEmptyView(systemImage: "calendar", message: "일정이 없습니다.")
                }
                
            }
        }//: VStack
        .onAppear{
            print()
        }
        .padding(20)
        .sheet(isPresented: $isShowingScheduleSheet, content: {
            ScheduleDetailView(scheduleId: selectedScheduleId)
        })
        .sheet(isPresented: $isShowingEditSheet, content: {
            ScheduleCellEditSheetView()
                .readHeight()
                .onPreferenceChange(HeightPreferenceKey.self) { height in
                    if let height {
                        self.detentHeight = height
                    }
                }
                .presentationDetents([.height(self.detentHeight)])
        })
    }
    func getSchedules() -> [Schedule] {
        
        let schedules = scheduleStore.schedules.filter {
            $0.gid == grew.id
        }
        return schedules
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

private struct ReadHeightModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}

extension View {
    func readHeight() -> some View {
        self
            .modifier(ReadHeightModifier())
    }
}

#Preview {
    ScheduleListView(
        grew: Grew(
            id: "",
            hostID: "",
            categoryIndex: "",
            categorysubIndex: "",
            title: "",
            description: "",
            imageURL: "",
            isOnline: false,
            location: "",
            latitude: nil,
            longitude: nil,
            geoHash: nil,
            gender: .any,
            minimumAge: 1,
            maximumAge: 10,
            maximumMembers: 10,
            currentMembers: [],
            isNeedFee: false,
            fee: 0,
            createdAt: Date(),
            heartUserDictionary: [:]
        )
    )
    .environmentObject(ScheduleStore())
}
