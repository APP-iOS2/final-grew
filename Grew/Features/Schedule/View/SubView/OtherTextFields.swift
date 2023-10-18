//
//  OtherTextFields.swift
//  Grew
//
//  Created by daye on 10/17/23.
//

//뷰를 거지같ㅌ이 짰어요 호호호호ㅗ호호호호ㅗㅎ호

import Foundation
import SwiftUI

struct ScheduleNameField: View {
    @Binding var isWrongScheduleName: Bool
    @Binding var scheduleName: String
    @FocusState var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("일정 이름").bold()
            ZStack{
                TextField("일정 이름", text: $scheduleName)
                    .padding(12)
                    .cornerRadius(8)
                    .focused($isTextFieldFocused)
                    .modifier(TextFieldErrorModifier(isError: $isWrongScheduleName, isTextFieldFocused: _isTextFieldFocused))
                    .onChange(of: isTextFieldFocused) { focused in
                        if !focused {
                            withAnimation(.easeIn){
                                if(scheduleName.count < 5){
                                    isWrongScheduleName = true
                                }else{
                                    isWrongScheduleName = false
                                }
                            }
                        }else {
                            isWrongScheduleName = false
                        }
                    }
                
                if isTextFieldFocused {
                    HStack{
                        Spacer()
                        Button {
                            scheduleName = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.Main)
                                .padding()
                        }
                    }
                }
            }
            if isWrongScheduleName {
                ErrorText(errorMessage: "5자 이상 입력해주세요.")
            }
        }.padding(1)
            .padding(.bottom, 5)
    }
    
}

struct GuestNumField: View {
    @Binding var isWrongGuestNum: Bool
    @State private var guestNumErrorMessage: String = ""
    @Binding var maximumMenbers: String
    @FocusState var isTextFieldFocused: Bool
    let meximumGrewMembers: Int = 20 //임시 그루 최대 인원
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.2.fill")
                Text("정원")
                    .padding(.trailing, 15)
                Spacer()
                ZStack{
                    TextField("정원", text: $maximumMenbers)
                        .keyboardType(.numberPad)
                        .padding(12)
                        .cornerRadius(8)
                        .focused($isTextFieldFocused)
                        .onChange(of: isTextFieldFocused) { focused in
                            if !focused {
                                guestErrorCheck()
                            }else {
                                isWrongGuestNum = false
                            }
                        }
                        .modifier(TextFieldErrorModifier(isError: $isWrongGuestNum, isTextFieldFocused: _isTextFieldFocused))
                    if isTextFieldFocused {
                        HStack{
                            Spacer()
                            Button {
                                maximumMenbers = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.Main)
                                    .padding()
                            }
                        }
                    }
                }
            }.padding(.top, 7)
            
            if isWrongGuestNum {
                ErrorText(errorMessage: guestNumErrorMessage)
            }
        }.padding(1)
    }
    
    func guestErrorCheck() {
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
}
