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
        
        //날짜
        HStack{
            Image(systemName: titleName == "날짜" ?  "calendar" : "clock")
            Text(titleName).padding(.trailing, 20)
            Spacer()
            
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(height: 45)
                    .cornerRadius(8)
                    .foregroundColor(Color("customGray"))
                    .onTapGesture {
                        isDatePickerVisible.toggle()
                    }
                Text(titleName == "날짜" ? dateStringFromDate(date) : dateStrngFormTime(date))
                    .foregroundColor(.gray).padding()
            }
            
        }
        .padding(.vertical,3)
        .bold()
    }
    
    func dateStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일" // 데이터 포맷
        return dateFormatter.string(from: date)
    }
    
    func dateStrngFormTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h시 m분" // 데이터 포맷
        return dateFormatter.string(from: date)
    }
}

struct DateForm: View {
    
    @Binding var isDatePickerVisible: Bool
    @Binding var date: Date
    
    var body: some View {
        DatePicker("일정", selection: $date, in: Date()...)
            .datePickerStyle(GraphicalDatePickerStyle())
            
            .tint(Color.red)
            .padding()
            .frame(width: 360, height: 400)
            .background(Color.white)
            .cornerRadius(8)
          // 시간선택 후 자동으로 어떻게 바꿔준담?
            .onChange(of: date){ _ in
                isDatePickerVisible.toggle()
            }
            .background{
                Rectangle()
                    .cornerRadius(8)
                    .shadow(radius: 20)
            }
    }
}
