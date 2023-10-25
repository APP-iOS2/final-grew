//
//  ScheduleOptionMenu.swift
//  Grew
//
//  Created by daye on 10/16/23.
//


import SwiftUI

struct ScheduleOptionMenu: View {
    
    var menuName: String
    @Binding var option: String
    @Binding var isOptionError: Bool
    @Binding var hasOption: Bool
    @Binding var isShowingWebSheet: Bool
    @State var errorMessage: String = "참가비를 입력해주세요."
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(menuName).font(.b2_R)
                Spacer()
                
                Button {
                    isOptionError = false
                    withAnimation(.easeIn){
                        hasOption = true
                    }
                } label: {
                    Text("있음")
                        .frame(width: 100, height: 32)
                        .background(hasOption ? Color(hexCode: "FF7E00") : Color(hexCode: "f2f2f2"))
                        .foregroundColor(hasOption ? .white : .gray)
                        .font(.b2_R)
                        .cornerRadius(8)
                }
                
                Button {
                    withAnimation(.easeIn){
                        hasOption = false
                        isOptionError = false
                        option = ""
                        errorMessage = ""
                    }
                } label: {
                    Text("없음")
                        .frame(width: 100, height: 32)
                        .background(!hasOption ? Color(hexCode: "FF7E00") : Color(hexCode: "f2f2f2"))
                        .foregroundColor(!hasOption ? .white : .gray)
                        .font(.b2_R)
                        .cornerRadius(8)
                }
            }
            if hasOption && menuName == "참가비" {
                ZStack{
                    TextField(menuName, text: $option)
                        .keyboardType(.decimalPad)
                        .font(.b2_R)
                        .padding(12)
                        .cornerRadius(8)
                        .focused($isTextFieldFocused)
                        .onChange(of: isTextFieldFocused){ focus in
                            withAnimation(.easeIn){
                                if !focus {
                                    if option.isEmpty {
                                        isOptionError = true
                                        errorMessage = "참가비를 입력해주세요."
                                    }
                                    if let intValue = Int(option) {
                                        isOptionError = false
                                    }else{
                                        isOptionError = true
                                        errorMessage = "숫자만 입력해주세요."
                                    }
                                }else {
                                    isOptionError = false
                                }
                            }
                        }
                        .modifier(TextFieldErrorModifier(isError: $isOptionError, isTextFieldFocused: _isTextFieldFocused))
                    
                    if isTextFieldFocused && !isOptionError{
                        HStack{
                            Spacer()
                            Button {
                                option = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.Main)
                                    .padding()
                            }
                        }
                    }
                }
                if isOptionError {
                    ErrorText(errorMessage: errorMessage)
                }
            }
            
            else if hasOption && menuName == "위치" {
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 45)
                        .cornerRadius(8)
                        .foregroundColor(Color(hexCode: "f2f2f2"))
                        .onTapGesture {
                            isShowingWebSheet = true
                            isOptionError = false
                        }
                        .modifier(RectangleModifier(isError: $isOptionError))
                        .padding(1)
                    if option.isEmpty{
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .padding(.leading, 10)
                            Text("주소 찾기").font(.b2_R)
                        }.padding(.leading, 5)
                    } else{
                        Text("\(option)")
                            .foregroundColor(Color.gray)
                            .font(.b2_R)
                            .padding(.leading, 15)
                    }
                }
                if isOptionError {
                    ErrorText(errorMessage: "위치를 선택해주세요.")
                }
            }
        }.padding(.top, 15)
    }
    
    func formatFee(_ value: String) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        if let number = formatter.number(from: value) {
            return formatter.string(from: number) ?? ""
        }
        return value
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}


#Preview {
    ScheduleOptionMenu(menuName: "위치", option: .constant(""), isOptionError: .constant(true), hasOption: .constant(true), isShowingWebSheet: .constant(false))
}
