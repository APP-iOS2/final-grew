//
//  CreateScheduleMainView.swift
//  Grew
//
//  Created by daye on 10/16/23.
//

// TODO
// 참가비 콤마 추가
// 오류시 빨간박스 처리
// 데이터 잘 입력 돼있는지 어케처리할거야????????????????대체???????????????
// 뷰 거지같다 정. 말.


import SwiftUI

struct CreateScheduleMainView: View {
    @ObservedObject var scheduleStore: ScheduleStore
    
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
    
    @State private var isWrongScheduleName: Bool = false
    @State private var isEmptyFeeError: Bool = false
    @State private var isEmptyLocationError: Bool = false
    @State private var isWrongGuestNum: Bool = false
    
    @State private var hasFee: Bool = false
    @State private var hasLocation: Bool = false
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack{
                    // 일정 이름
                    ScheduleNameField(isWrongScheduleName: $isWrongScheduleName, scheduleName: $scheduleName)
                    
                    // 날짜, 시간
                    ScheduleDatePicker(titleName: "날짜", isDatePickerVisible: $isDatePickerVisible, date: $date)
                    ScheduleDatePicker(titleName: "시간", isDatePickerVisible: $isDatePickerVisible, date: $date)
                    
                    // 정원
                    GuestNumField(isWrongGuestNum: $isWrongGuestNum, maximumMenbers: $maximumMenbers)
                    
                    // 선택 메뉴
                    ScheduleOptionMenu(menuName: "참가비", option: $fee, isEmptyOptionError: $isEmptyFeeError, hasOption: $hasFee, isShowingWebSheet: $showingWebSheet)
                    ScheduleOptionMenu(menuName: "위치", option: $location, isEmptyOptionError: $isEmptyLocationError, hasOption: $hasLocation, isShowingWebSheet: $showingWebSheet )
                    
                    // 배너 색상 선택
                    ScheduleColorPicker(colorPick: $colorPick)
                    
                    
                }.padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
            }.navigationTitle("일정 생성")
                .navigationBarTitleDisplayMode(.inline)
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
                    .modifier(GrewAlertModifier(isPresented: $showingFinishAlert, title: "일정 생성 완료!", buttonTitle: "확인", buttonColor: Color.grewMainColor, action: finishCreate))
            }
        }
        .sheet(isPresented: $showingWebSheet, content: {
            ZStack{
                WebView(request: URLRequest(url: URL(string: "https://da-hye0.github.io/Kakao-Postcode/")!), showingWebSheet: $showingWebSheet, location: $location, latitude: $latitude, longitude: $longitude)
                /*if isLoading {
                 ProgressView()
                 }*/
            }
        })
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
    
    //그냥 에러메세지가 있으면 오류, 없으면 입력 완료. 오류검사는 메인뷰에서.
    
    
    func errorCheck() {
        if scheduleName.isEmpty {
            isWrongScheduleName = true
            return
        }
        if maximumMenbers.isEmpty {
            isWrongGuestNum = true
            return
        }
        
        withAnimation(.easeOut){
            showingFinishAlert.toggle()
        }
        
    }
    func finishCreate() {
        
    }
}

#Preview {
    NavigationStack{
        CreateScheduleMainView(scheduleStore: ScheduleStore())
    }
}
