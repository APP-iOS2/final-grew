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
    @Binding var showingWebSheet: Bool
    @Binding var isEmptyOptionError: Bool
    @State private var hasOption: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(menuName).bold()
                Spacer()
                
                Button {
                    isEmptyOptionError = false
                    withAnimation(.easeIn){
                        hasOption = true
                    }
                } label: {
                    Text("있음")
                        .frame(width: 100, height: 32)
                        .background(hasOption ? Color(hexCode: "FF7E00") : Color(hexCode: "f2f2f2"))
                        .foregroundColor(hasOption ? .white : .gray)
                        .bold()
                        .cornerRadius(8)
                }
                
                Button {
                    withAnimation(.easeIn){
                        hasOption = false
                        isEmptyOptionError = false
                        option = ""
                    }
                } label: {
                    Text("없음")
                        .frame(width: 100, height: 32)
                        .background(!hasOption ? Color(hexCode: "FF7E00") : Color(hexCode: "f2f2f2"))
                        .foregroundColor(!hasOption ? .white : .gray)
                        .bold()
                        .cornerRadius(8)
                }
            }
            
           if(hasOption && menuName == "참가비") {
                TextField(menuName, text: $option)
                    .keyboardType(.decimalPad)
                    .padding(12)
                    .cornerRadius(8)
                    .onChange(of: option){ newFee in
                        option = formatFee(newFee)
                        if (!option.isEmpty){
                            isEmptyOptionError = false
                        }
                    }
                    .modifier(TextFieldErrorModifier(isError: $isEmptyOptionError))
                if isEmptyOptionError {
                    ErrorText(errorMessage: "참가비를 입력해주세요.")
                }
            }
           else if(hasOption && menuName == "위치") {
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 45)
                        .cornerRadius(8)
                        .foregroundColor(Color(hexCode: "f2f2f2"))
                        .onTapGesture {
                            showingWebSheet = true
                            isEmptyOptionError = false
                        }
                        .modifier(TextFieldErrorModifier(isError: $isEmptyOptionError))
                        .padding(1)
                    Text("\(option)")
                }
                if isEmptyOptionError {
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
    ScheduleOptionMenu(menuName: "참가비", option: .constant(""), showingWebSheet: .constant(false), isEmptyOptionError: .constant(true))
}
