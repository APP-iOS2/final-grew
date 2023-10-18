//
//  CreateScheduleMainView.swift
//  Grew
//
//  Created by daye on 10/16/23.
//

// TODO

// 참가비 천단위 콤마 추가
// 통신 후 showingWebSheet 닫기
// 오류시 빨간박스 처리 함수 만들기
// 패딩 조절하기
// 박스들 쩜 뚱뚱한가,,?
// 옵션 메뉴들 버튼 클릭할때 거슬리는가?


import SwiftUI

struct CreateScheduleMainView: View {
    
    @ObservedObject var scheduleStore: ScheduleStore
    
    @State private var scheduleName: String = ""
    @State private var date = Date()
    @State private var maximumMenbers: String = "2"
    @State private var fee: String = ""
    @State private var location: String = ""
    @State private var colorPick: String = ""
 
    @State private var isEmptyFeeError: Bool = false
    @State private var isEmptyLocationError: Bool = false
    
    @State private var isDatePickerVisible: Bool = false
    @State private var showingWebSheet: Bool = false
    @State private var showingFinishAlert: Bool = false
    
    @State private var isLoading: Bool = true
    
    let meximumGrewMembers: Int = 20 //임시. 그루 최대 인원 받아와야함!
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack{
                    
                    // 일정 이름
                    scheduleNameField
                    
                    // 날짜, 시간
                    ScheduleDatePicker(titleName: "날짜", isDatePickerVisible: $isDatePickerVisible, date: $date)
                    ScheduleDatePicker(titleName: "시간", isDatePickerVisible: $isDatePickerVisible, date: $date)
                    
                    // 정원
                    guestNumField
                    
                    // 선택 메뉴
                    ScheduleOptionMenu(menuName: "참가비", option: $fee, isEmptyOptionError: $isEmptyFeeError, isShowingWebSheet: $showingWebSheet)
                    ScheduleOptionMenu(menuName: "위치", option: $location,isEmptyOptionError: $isEmptyLocationError, isShowingWebSheet: $showingWebSheet)
                    
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
                WebView(request: URLRequest(url: URL(string: "https://da-hye0.github.io/Kakao-Postcode/")!), showingWebSheet: $showingWebSheet, location: $location)
                /*if isLoading {
                    ProgressView()
                }*/
            }
        })
        .task{
            print(showingWebSheet)
        }
        // ondismiss써서 location 불러오기?
    }
    
    /* 간단 하위뷰 */
    
    // 일정 이름 필드
    @State private var isWrongScheduleName: Bool = false
    @FocusState var isTextFieldFocused: Bool
    private var scheduleNameField: some View {
        VStack(alignment: .leading){
            Text("일정 이름").bold()

            TextField("일정 이름", text: $scheduleName)
                .padding(12)
                .cornerRadius(8)
                .modifier(TextFieldErrorModifier(isError: $isWrongScheduleName))
                .onChange(of: scheduleName){
                    withAnimation(.easeIn){
                        if(scheduleName.count < 5){
                            isWrongScheduleName = true
                        }else{
                            isWrongScheduleName = false
                        }
                    }
                }
                .focused($isTextFieldFocused)
            if isWrongScheduleName {
                ErrorText(errorMessage: "5자 이상 입력해주세요.")
            }
        }.padding(1)
            .padding(.bottom, 5)
    }
    
    // 정원 필드
    @State private var isWrongGuestNum: Bool = false
    @State private var guestNumErrorMessage: String = ""
    
    private var guestNumField: some View {
        VStack{
            HStack{
                Image(systemName: "person.2.fill")
                Text("정원")
                    .padding(.trailing, 15)
                Spacer()
                
                TextField("정원", text: $maximumMenbers)
                    .keyboardType(.numberPad)
                    .padding(12)
                    .cornerRadius(8)
                    .onChange(of: maximumMenbers){
                        withAnimation(.easeIn){
                            if let intValue = Int(maximumMenbers) {
                                if intValue > meximumGrewMembers {
                                    isWrongGuestNum = true
                                    guestNumErrorMessage = "그룹 인원보다 많습니다."
                                } else if intValue < 2 {
                                    isWrongGuestNum = true
                                    guestNumErrorMessage = "2명 이상 입력하세요."
                                } else {
                                    isWrongGuestNum = false
                                    guestNumErrorMessage = ""
                                }
                            } else {
                                isWrongGuestNum = true
                                if maximumMenbers.isEmpty{
                                    guestNumErrorMessage = "숫자를 입력해주세요."
                                }
                                else{
                                    guestNumErrorMessage = "숫자만 입력하세요."
                                }
                            }
                        }
                    }
                    .modifier(TextFieldErrorModifier(isError: $isWrongGuestNum))
            }.padding(.top, 7)
            
            if isWrongGuestNum {
                ErrorText(errorMessage: guestNumErrorMessage)
            }
        }.padding(1)
    }
    
    // 일정 생성 버튼
    private var submitBtn: some View {
        Button {
            //location = kakaoWebData.dataArrays[1]
            withAnimation(.easeOut){
                showingFinishAlert.toggle()
            }
           
        } label: {
            Text("일정 생성")
                .frame(width: 350, height: 45)
                .foregroundColor(.white)
                .background(Color.grewMainColor)
                .cornerRadius(8)
                .bold()
        }
    }
    
    func errorCheck() {
        
    }
    
    public func finishCreate() {
        
    }
}

#Preview {
    NavigationStack{
        CreateScheduleMainView(scheduleStore: ScheduleStore())
    }
}
