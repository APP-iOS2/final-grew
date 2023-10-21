//
//  StumpInputView.swift
//  Grew
//
//  Created by 김효석 on 10/21/23.
//

import SwiftUI

struct StumpInputView: View {
    
    @Binding var name: String
    @Binding var hours: String
    @Binding var minimumMembers: String
    @Binding var maximumMembers: String
    @Binding var isNeedDeposit: Bool
    @Binding var deposit: String
    @Binding var location: String
    @Binding var phoneNumber: String
    let isAllTextFieldDisabled: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("그루터기 이름")
                .font(.b2_R)
                .padding(.top)
            GrewTextField(
                text: $name,
                isWrongText: false,
                isTextfieldDisabled: isAllTextFieldDisabled ? true : false,
                placeholderText: "이름",
                isSearchBar: false
            )
            .padding(.bottom, 18)
            
            HStack {
                Image(systemName: "stopwatch")
                    .font(.b2_R)
                Text("운영 시간")
                    .font(.b2_R)
                GrewTextField(
                    text: $hours,
                    isWrongText: false,
                    isTextfieldDisabled: isAllTextFieldDisabled ? true : false,
                    placeholderText: "00:00 ~ 00:00",
                    isSearchBar: false
                )
            }
            .padding(.bottom, 18)
            
            HStack {
                Image(systemName: "person.2.fill")
                    .font(.b2_R)
                Text("적정 인원")
                    .font(.b2_R)
                GrewTextField(
                    text: $minimumMembers,
                    isWrongText: false,
                    isTextfieldDisabled: isAllTextFieldDisabled ? true : false,
                    placeholderText: "최소 인원",
                    isSearchBar: false
                )
                GrewTextField(
                    text: $maximumMembers,
                    isWrongText: false,
                    isTextfieldDisabled: isAllTextFieldDisabled ? true : false,
                    placeholderText: "최대 인원",
                    isSearchBar: false
                )
            }
            .padding(.bottom, 18)
            
            HStack {
                Text("보증금")
                    .font(.b2_R)
                Spacer()
                Button {
                    isNeedDeposit = true
                } label: {
                    Text("있음")
                        .frame(width: 100, height: 32)
                }
                .disabled(isAllTextFieldDisabled ? true : false)
                .grewButtonModifier(
                    width: 100,
                    height: 32,
                    buttonColor: isNeedDeposit ? .Sub : .BackgroundGray,
                    font: .b2_R,
                    fontColor: isNeedDeposit ? .white : .DarkGray1,
                    cornerRadius: 8
                )
                
                Button {
                    isNeedDeposit = false
                } label: {
                    Text("없음")
                        .frame(width: 100, height: 32)
                }
                .disabled(isAllTextFieldDisabled ? true : false)
                .grewButtonModifier(
                    width: 100,
                    height: 32,
                    buttonColor: !isNeedDeposit ? .Sub : .BackgroundGray,
                    font: .b2_R,
                    fontColor: !isNeedDeposit ? .white : .DarkGray1,
                    cornerRadius: 8
                )
            }
            GrewTextField(
                text: $deposit,
                isWrongText: false,
                isTextfieldDisabled: isAllTextFieldDisabled ? true : (isNeedDeposit ? false : true),
                placeholderText: "예: 50,000원",
                isSearchBar: false
            )
            .padding(.bottom, 18)
            
            Text("위치")
                .font(.b2_R)
            GrewTextField(
                text: $location,
                isWrongText: false,
                isTextfieldDisabled: isAllTextFieldDisabled ? true : false,
                placeholderText: "00시 00구 00로 00길 00",
                isSearchBar: false
            )
            .padding(.bottom, 18)
            
            Text("그루터기 전화번호")
                .font(.b2_R)
            GrewTextField(
                text: $phoneNumber,
                isWrongText: false,
                isTextfieldDisabled: isAllTextFieldDisabled ? true : false,
                placeholderText: "전화번호",
                isSearchBar: false
            )
            .padding(.bottom, 18)
        }
    }
}

#Preview {
    StumpInputView(
        name: .constant("이름"),
        hours: .constant("운영시간"),
        minimumMembers: .constant("최소 인원"),
        maximumMembers: .constant("최대 인원"),
        isNeedDeposit: .constant(true),
        deposit: .constant("20,000"),
        location: .constant("주소"),
        phoneNumber: .constant("전화번호"),
        isAllTextFieldDisabled: true
    )
}
