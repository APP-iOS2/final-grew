//
//  ScheduleColorPicker.swift
//  Grew
//
//  Created by daye on 10/16/23.
//

import SwiftUI

struct ScheduleColorPicker: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    @State private var colorIndex: Int = 0
    
    var body: some View {
        VStack(alignment: .leading){
            Text("배너 색상").bold()
            LazyVGrid(columns: columns) {
                ForEach((0..<8), id: \.self) { i in
                    ZStack{
                        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                            .frame(width: 70, height: 70)
                            .onTapGesture {
                                colorIndex = i
                            }
                            .padding(3)
                        
                        if(colorIndex == i){
                            Image(systemName: "checkmark.square.fill")
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                        }
                    }
                }
            }//.padding(.vertical, 5)
                .padding(.horizontal, 15)
            
        }.padding(.top,20)
        
    }
}

#Preview {
    ScheduleColorPicker()
}
