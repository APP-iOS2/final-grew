//
//  ScheduleOptionMenu.swift
//  Grew
//
//  Created by daye on 10/16/23.
//


import SwiftUI

struct ScheduleOptionMenu: View {
    
    var menuName: String
    @State private var fee: String = ""
    @State private var hasOption: Bool = false
    @Binding var showingWebSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(menuName).bold()
                Spacer()
                
                Button {
                    withAnimation(.easeIn){
                        hasOption = true
                    }
                    
                } label: {
                    Text("있음")
                        .frame(width: 100, height: 35)
                        .background(hasOption ? Color.orange : Color("customGray"))
                        .foregroundColor(hasOption ? .white : .gray)
                        .bold()
                        .cornerRadius(8)
                }
                
                Button {
                    withAnimation(.easeIn){
                        hasOption = false
                    }
                } label: {
                    Text("없음")
                        .frame(width: 100, height: 35)
                        .background(!hasOption ? Color.orange : Color("customGray"))
                        .foregroundColor(!hasOption ? .white : .gray)
                        .bold()
                        .cornerRadius(8)
                }
            }
            
            if(hasOption && menuName == "참가비") {
                TextField(menuName, text: $fee)
                    .keyboardType(.decimalPad)
                    .padding(12)
                    .background(Color("customGray"))
                    .cornerRadius(8)
                    .onChange(of: fee){ newFee in
                        fee = formatFee(newFee)
                    }
            }
            else if(hasOption && menuName == "위치") {
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 45)
                        .cornerRadius(8)
                        .foregroundColor(Color("customGray"))
                        .onTapGesture {
                            showingWebSheet = true
                        }
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
    ScheduleOptionMenu(menuName: "참가비", showingWebSheet: .constant(false))
}
