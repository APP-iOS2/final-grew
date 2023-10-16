//
//  CreateScheduleMainView.swift
//  Grew
//
//  Created by daye on 10/16/23.
//

// TODO
// 참가비 콤마 추가
// 오류시 빨간박스 처리
// safetyAreaInset 뒷부분 투명처리
// 박스들 쩜 뚱뚱한가,,?

import SwiftUI

struct CreateScheduleMainView: View {
    
    @State private var scheduleName: String = ""
    @State private var guestNum: String = "2"
    
    @State private var isOpenForm: Bool = false
    @State private var hasEntryFee: Bool = false
    
    @State private var date = Date()
    @State private var isDatePickerVisible: Bool = false
    
    @State private var showingWebSheet: Bool = false
 
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    //일정 이름
                    scheduleNameField
                    
                    //날짜, 시간
                    ScheduleDatePicker(titleName: "날짜", isDatePickerVisible: $isDatePickerVisible, date: $date)
                    ScheduleDatePicker(titleName: "시간", isDatePickerVisible: $isDatePickerVisible, date: $date)
                    
                    //정원
                    guestNumField
                    
                    //선택 메뉴
                    ScheduleOptionMenu(menuName: "참가비", showingWebSheet: $showingWebSheet)
                    ScheduleOptionMenu(menuName: "위치", showingWebSheet: $showingWebSheet)
                    
                    //배너 색상 선택
                    ScheduleColorPicker()
                }
            }.navigationTitle("일정 생성")
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom) {
                    submitBtn
                }
                .background(Color.white.opacity(0.5))
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
                //.disabled(isDatePickerVisible)
            
            if isDatePickerVisible {
                DateForm(isDatePickerVisible: $isDatePickerVisible, date: $date)
            }
        }.sheet(isPresented: $showingWebSheet) { //sheet로 사이트 열기
            KakaoPostWebView(siteURL: "")
        }
    }
 
    
    /* 하위뷰 */
    
    // 일정 이름 필드
    private var scheduleNameField: some View {
        VStack(alignment: .leading){
            Text("일정 이름").bold()
            TextField("일정 이름", text: $scheduleName)
                .padding(12)
                .background(Color("customGray"))
                .cornerRadius(8)
        }
    }

    // 정원 필드
    private var guestNumField: some View {
        HStack{
            Image(systemName: "person.2.fill")
            Text("정원").padding(.trailing,15)
            Spacer()
            
            TextField("참가 인원", text: $guestNum)
                .keyboardType(.numberPad)
                .padding(12)
                .background(Color("customGray"))
                .cornerRadius(8)
        }
    }
    
    // 일정 생성 버튼
    private var submitBtn: some View {
        Button {
            
        } label: {
            Text("일정 생성")
                .frame(width:350, height: 45)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(8)
                .bold()
        }
    }
}


#Preview {
    NavigationStack{
        CreateScheduleMainView()
    }
}
