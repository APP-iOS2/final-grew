//
//  CreateScheduleMainView.swift
//  Grew
//
//  Created by daye on 10/16/23.
//

// TODO
// 참가비 콤마 추가

import SwiftUI

struct CreateScheduleMainView: View {
    @EnvironmentObject var scheduleStore: ScheduleStore
    let gid: String
    @State private var scheduleName: String = ""
    @State private var date = Date()
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
                    // 일정 이름
                    
                    ScheduleNameField(isScheduleNameError: $isScheduleNameError, scheduleName: $scheduleName)
                    
                    // 날짜, 시간
                    ScheduleDatePicker(titleName: "날짜", isDatePickerVisible: $isDatePickerVisible, date: $date)
                    ScheduleDatePicker(titleName: "시간", isDatePickerVisible: $isDatePickerVisible, date: $date)
                    
                    // 정원
                    GuestNumField(isGuestNumError: $isGuestNumError, maximumMenbers: $maximumMenbers)
                    
                    // 선택 메뉴
                    ScheduleOptionMenu(menuName: "참가비", option: $fee, isOptionError: $isFeeError, hasOption: $hasFee, isShowingWebSheet: $showingWebSheet)
                    ScheduleOptionMenu(menuName: "위치", option: $location, isOptionError: $isLocationError, hasOption: $hasLocation, isShowingWebSheet: $showingWebSheet )
                    
                    // 배너 색상 선택
                    ScheduleColorPicker(colorPick: $colorPick)
                    
                    
                }.padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
            }.navigationTitle("일정 생성")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
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
                .safeAreaInset(edge: .bottom) {
                    submitBtn
                        .background(Color.white.opacity(0.8))
                }
                .disabled(isDatePickerVisible)
                .onTapGesture {
                    if isDatePickerVisible {
                        isDatePickerVisible.toggle()
                    }
                }
            
            // DatePicker
            if isDatePickerVisible {
                DateForm(isDatePickerVisible: $isDatePickerVisible, date: $date)
            }
            
            // alert
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
                        //                        finishCreate()
                    }
                //                    .modifier(GrewAlertModifier(isPresented: $showingFinishAlert, title: "일정 생성 완료!", buttonTitle: "확인", buttonColor: Color.grewMainColor, action: finishCreate))
            }
        }
        .sheet(isPresented: $showingWebSheet, content: {
            VStack{
                WebView(request: URLRequest(url: URL(string: "https://da-hye0.github.io/Kakao-Postcode/")!), showingWebSheet: $showingWebSheet, location: $location, latitude: $latitude, longitude: $longitude)
                .padding(.top, 25)
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        )
        
        .task{
            print(showingWebSheet)
        }
    }
    
    // 일정 생성 버튼
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
    
    //포커스인곳 처리
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
        do {
            let newSchedule = Schedule(
                id: id,
                gid: gid,
                scheduleName: scheduleName,
                date: date,
                maximumMember: Int(maximumMenbers) ?? 2,
                participants: [],
                fee: (hasFee ? fee : nil),
                location: (hasLocation ? location : nil),
                latitude: (hasLocation ? latitude : nil),
                longitude: (hasLocation ? longitude : nil),
                color: colorPick
            )
            scheduleStore.addSchedule(newSchedule)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack{
        CreateScheduleMainView(gid: "")
            .environmentObject(ScheduleStore())
    }
}
