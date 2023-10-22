//
//  StumpInputView.swift
//  Grew
//
//  Created by 김효석 on 10/21/23.
//

import SwiftUI

struct StumpInputView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var name: String
    @Binding var hours: String
    @Binding var isHoursValid: Bool
    @Binding var minimumMembers: String
    @Binding var maximumMembers: String
    @Binding var isNeedDeposit: Bool
    @Binding var deposit: String
    @Binding var location: String
    @Binding var phoneNumber: String
    let isAllTextFieldDisabled: Bool
    var imageURLs: [String] = []
    
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var isShowingLocationSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("그루터기 이름")
                .font(.b2_R)
                .padding(.top)
            GrewTextField(
                text: $name,
                isWrongText: false,
                isTextfieldDisabled: isAllTextFieldDisabled,
                placeholderText: "이름",
                isSearchBar: false
            )
            .padding(.bottom, 18)
            
            HStack {
                Image(systemName: "stopwatch")
                    .font(.b2_R)
                    .padding(.trailing, 6)
                Text("운영 시간")
                    .font(.b2_R)
                GrewTextField(
                    text: $hours,
                    isWrongText: !isHoursValid,
                    isTextfieldDisabled: isAllTextFieldDisabled,
                    placeholderText: "예) 09:00~14:00",
                    isSearchBar: false
                )
            }
            .padding(.bottom, isHoursValid ? 18 : 0)
            
            if !isHoursValid {
                HStack {
                    Spacer()
                    Text("양식에 맞게 입력해주세요.")
                        .font(.c2_L)
                        .foregroundStyle(Color.Error)
                }
            }
            
            HStack {
                Image(systemName: "person.2.fill")
                    .font(.b2_R)
                Text("적정 인원")
                    .font(.b2_R)
                GrewTextField(
                    text: $minimumMembers,
                    isWrongText: false,
                    isTextfieldDisabled: isAllTextFieldDisabled,
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
                .disabled(isAllTextFieldDisabled)
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
//            GrewTextField(
//                text: $location,
//                isWrongText: false,
//                isTextfieldDisabled: isAllTextFieldDisabled ? true : false,
//                placeholderText: "00시 00구 00로 00길 00",
//                isSearchBar: false
//            )
//            .padding(.bottom, 18)
            Button {
                isShowingLocationSheet = true
            } label: {
                if location.isEmpty {
                    Image(systemName: "magnifyingglass")
                    Text("주소 검색하기")
                } else {
                    Text(location)
                }
            }
            .grewButtonModifier(width: UIScreen.screenWidth - 40, height: 44, buttonColor: .LightGray1, font: .b3_R, fontColor: .black, cornerRadius: 10)
            .disabled(isAllTextFieldDisabled)
            .padding(.bottom, 18)
            
            Text("그루터기 전화번호")
                .font(.b2_R)
            GrewTextField(
                text: $phoneNumber,
                isWrongText: false,
                isTextfieldDisabled: isAllTextFieldDisabled,
                placeholderText: "전화번호",
                isSearchBar: false
            )
            .padding(.bottom, 18)
            
            if isAllTextFieldDisabled {
                Text("그루터기 사진")
                    .font(.b2_R)
                HStack {
                    Spacer()
                    VStack {
                        ForEach(0..<3) { index in
                            if index < imageURLs.count {
                                ZStack {
                                    Rectangle()
                                        .stroke(Color.black)
                                        .frame(width: 250, height: 250)
                                    AsyncImage(url: URL(string: imageURLs[index])) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 250, height: 250)
                                    } placeholder: {
                                        Image("logo")
                                            .frame(width: 250, height: 250)
                                    }
                                }
                            } else {
                                Rectangle()
                                    .stroke(Color.black)
                                    .frame(height: 110)
                            }
                        }
                    }
                    Spacer()
                }
            }
            
        }
        .onChange(of: hours) {
            isHoursValid = {
                let pattern = "^([01][0-9]|2[0-3]|24):[0-5][0-9]~([01][0-9]|2[0-3]|24):[0-5][0-9]$"
                let regex = try? NSRegularExpression(pattern: pattern)
                let range = NSRange(location: 0, length: hours.utf16.count)
                return regex?.firstMatch(in: hours, options: [], range: range) != nil
            }()
        }
        .sheet(isPresented: $isShowingLocationSheet) {
            WebView(
                request: URLRequest(url: URL(string: "https://da-hye0.github.io/Kakao-Postcode/")!),
                showingWebSheet: $isShowingLocationSheet,
                location: $location,
                latitude: $latitude,
                longitude: $longitude
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(isAllTextFieldDisabled ? "그루터기 상세보기" : "그루터기 등록하기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.black)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    StumpInputView(
        name: .constant("이름"),
        hours: .constant("운영시간"),
        isHoursValid: .constant(false),
        minimumMembers: .constant("최소 인원"),
        maximumMembers: .constant("최대 인원"),
        isNeedDeposit: .constant(true),
        deposit: .constant("20,000"),
        location: .constant(""),
        phoneNumber: .constant("전화번호"),
        isAllTextFieldDisabled: false,
        imageURLs: ["", "", ""]
    )
}
