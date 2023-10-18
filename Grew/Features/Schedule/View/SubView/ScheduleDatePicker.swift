//
//  ScheduleDatePicker.swift
//  Grew
//
//  Created by daye on 10/16/23.
//

import SwiftUI

struct ScheduleDatePicker: View {
    var titleName: String
    @Binding var isDatePickerVisible: Bool
    @Binding var date: Date
    
    var body: some View {
        HStack{
            Image(systemName: titleName == "날짜" ?  "calendar" : "clock")
            Text(titleName).padding(.trailing, 20)
            Spacer()
            
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(height: 45)
                    .cornerRadius(8)
                    .foregroundColor(Color(hexCode: "f2f2f2"))
                    .onTapGesture {
                        isDatePickerVisible.toggle()
                    }.padding(1)
                Text(titleName == "날짜" ? dateStringFromDate(date) : dateStringFormTime(date))
                    .foregroundColor(.gray).padding()
            }
        }.padding(.vertical, 5)
        .bold()
    }
    
    // 날짜 포맷
    func dateStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"
        return dateFormatter.string(from: date)
    }
    
    // 시간 포맷
    func dateStringFormTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h시 m분"
        return dateFormatter.string(from: date)
    }
}

// DatePicker
struct DateForm: View {
    
    @Binding var isDatePickerVisible: Bool
    @Binding var date: Date
    
    var body: some View {
        DatePicker("일정", selection: $date, in: Date()...)
            .padding()
            .datePickerStyle(GraphicalDatePickerStyle())
            .tint(Color.red)
            .frame(width: 360, height: 400)
            .background(Color.white)
            .cornerRadius(8)
            .background{
                Rectangle()
                    .cornerRadius(8)
                    .shadow(radius: 5)
            }
            .padding()
    }
}
