//
//  OtherTextFields.swift
//  Grew
//
//  Created by daye on 10/17/23.
//

import Foundation
import SwiftUI

struct ScheduleNameField: View {
    @Binding var isScheduleNameError: Bool
    @Binding var scheduleName: String
    @FocusState var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("일정 이름")
                .font(.b2_R)
            ZStack{
                TextField("일정 이름", text: $scheduleName)
                    .font(.b2_R)
                    .padding(12)
                    .cornerRadius(8)
                    .focused($isTextFieldFocused)
                    .modifier(TextFieldErrorModifier(isError: $isScheduleNameError, isTextFieldFocused: _isTextFieldFocused))
                    .onChange(of: isTextFieldFocused) { focused in
                        if !focused {
                            withAnimation(.easeIn){
                                if scheduleName.count < 5 {
                                    isScheduleNameError = true
                                } else{
                                    isScheduleNameError = false
                                }
                            }
                        } else {
                            isScheduleNameError = false
                        }
                    }
                
                if isTextFieldFocused && !isScheduleNameError {
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
            if isScheduleNameError {
                ErrorText(errorMessage: "5자 이상 입력해주세요.")
            }
        }.padding(1)
            .padding(.bottom, 5)
    }
    
}

struct GuestNumField: View {
    @Binding var isGuestNumError: Bool
    @State private var guestNumErrorMessage: String = "정원을 입력해주세요."
    @Binding var maximumMenbers: String
    @FocusState var isTextFieldFocused: Bool
    let meximumGrewMembers: Int = 20
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.2.fill")
                Text("정원")
                    .font(.b2_R)
                    .padding(.trailing, 15)
                Spacer()
                ZStack{
                    TextField("정원", text: $maximumMenbers)
                        .keyboardType(.numberPad)
                        .padding(12)
                        .cornerRadius(8)
                        .font(.b2_R)
                        .focused($isTextFieldFocused)
                        .onChange(of: isTextFieldFocused) { focused in
                            if !focused {
                                guestErrorCheck()
                            } else {
                                isGuestNumError = false
                            }
                        }
                        .modifier(TextFieldErrorModifier(isError: $isGuestNumError, isTextFieldFocused: _isTextFieldFocused))
                    if isTextFieldFocused && !isGuestNumError {
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
            
            if isGuestNumError {
                ErrorText(errorMessage: guestNumErrorMessage)
            }
        }.padding(1)
    }
    
    public func guestErrorCheck() {
        withAnimation(.easeIn){
            if let intValue = Int(maximumMenbers) {
                if intValue > meximumGrewMembers {
                    isGuestNumError = true
                    guestNumErrorMessage = "그룹 인원보다 많습니다."
                } else if intValue < 2 {
                    isGuestNumError = true
                    guestNumErrorMessage = "2명 이상 입력하세요."
                } else {
                    isGuestNumError = false
                    guestNumErrorMessage = "정원을 입력해주세요."
                }
            } else {
                isGuestNumError = true
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
