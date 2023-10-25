//
//  CreateScheduleMainView.swift
//  Grew
//
//  Created by daye on 10/16/23.
//

import SwiftUI

struct CreateScheduleMainView: View {
    @EnvironmentObject var scheduleStore: ScheduleStore
    let gid: String
    @State private var scheduleName: String = ""
    @State private var maximumMenbers: String = ""
    @State private var fee: String = ""
    @State private var location: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var colorPick: String = ""
    
    @State private var isDatePickerVisible: Bool = false
    @State private var showingWebSheet: Bool = false
    @State private var showingFinishAlert: Bool = false
    @Environment (\.dismiss) var dismiss
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack{

                    ScheduleNameField(isScheduleNameError: $isScheduleNameError, scheduleName: $scheduleName)

                    ScheduleDatePicker(titleName: "날짜", isDatePickerVisible: $isDatePickerVisible, date: $scheduleStore.date)
                    ScheduleDatePicker(titleName: "시간", isDatePickerVisible: $isDatePickerVisible, date: $scheduleStore.date)

                    GuestNumField(isGuestNumError: $isGuestNumError, maximumMenbers: $maximumMenbers)

                    ScheduleOptionMenu(menuName: "참가비", option: $fee, isOptionError: $isFeeError, hasOption: $hasFee, isShowingWebSheet: $showingWebSheet)
                    ScheduleOptionMenu(menuName: "위치", option: $location, isOptionError: $isLocationError, hasOption: $hasLocation, isShowingWebSheet: $showingWebSheet )
                    
                    ScheduleColorPicker(colorPick: $colorPick)
                    
                    submitBtn
                        .padding(.top, 50)
                        .background(Color.white.opacity(0.8))
                }.padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
            }.navigationTitle("일정 생성")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .scrollDismissesKeyboard(.immediately)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 18))
                                .foregroundStyle(Color.black)
                        }
                    }
                    
                }
                .onAppear{
                    scheduleStore.fetchSchedule()
                }
                .disabled(isDatePickerVisible)
                .onTapGesture {
                    if isDatePickerVisible {
                        isDatePickerVisible.toggle()
                    }
                }
            
            if isDatePickerVisible {
                DateForm(isDatePickerVisible: $isDatePickerVisible, date: $scheduleStore.date)
            }
            
            if showingFinishAlert {
                Color.clear
                    .grewAlert(
                        isPresented: $showingFinishAlert,
                        title: "일정 생성 완료!",
                        secondButtonTitle: nil,
                        secondButtonColor: nil,
                        secondButtonAction: nil,
                        buttonTitle: "확인",
                        buttonColor: Color.grewMainColor
                    ) {
                        dismiss()
                    }
            }
        }
        .sheet(isPresented: $showingWebSheet, content: {
            ZStack{
                WebView(request: URLRequest(url: URL(string: "https://da-hye0.github.io/Kakao-Postcode/")!), showingWebSheet: $showingWebSheet, location: $location, latitude: $latitude, longitude: $longitude)
                    .padding(.top, 25)
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        )
    }
    
    /// 일정 생성 버튼
    private var submitBtn: some View {
        Button {
            errorCheck()
            
        } label: {
            Text("일정 생성")
                .frame(width: 350, height: 45)
                .foregroundColor(.white)
                .background(Color.grewMainColor)
                .cornerRadius(8)
                .bold()
        }
    }
    
    
    @State private var isScheduleNameError: Bool = false
    @State private var isFeeError: Bool = false
    @State private var isLocationError: Bool = false
    @State private var isGuestNumError: Bool = false
    
    @State private var hasFee: Bool = false
    @State private var hasLocation: Bool = false
    
    func errorCheck() {
        withAnimation(.easeOut){
            if scheduleName.isEmpty {
                isScheduleNameError = true
                return
            }
            if maximumMenbers.isEmpty {
                isGuestNumError = true
                return
            }
            if fee.isEmpty && hasFee {
                isFeeError = true
                return
            }
            if location.isEmpty && hasLocation {
                isLocationError = true
                return
            }
            createSchedule()
            showingFinishAlert.toggle()
        }
    }
    
    func createSchedule() {
        let id = UUID().uuidString
        if let user = UserStore.shared.currentUser {
            let newSchedule = Schedule(
                id: id,
                gid: gid,
                scheduleName: scheduleName,
                date: scheduleStore.date,
                maximumMember: Int(maximumMenbers) ?? 2,
                participants: [user.id ?? ""],
                fee: (hasFee ? fee : nil),
                location: (hasLocation ? location : nil),
                latitude: (hasLocation ? latitude : nil),
                longitude: (hasLocation ? longitude : nil),
                color: colorPick
            )
            scheduleStore.addSchedule(newSchedule)
        } 
    }
}


#Preview {
    NavigationStack{
        CreateScheduleMainView(gid: "")
            .environmentObject(ScheduleStore())
    }
}
