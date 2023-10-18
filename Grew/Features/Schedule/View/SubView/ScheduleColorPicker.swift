//
//  ScheduleColorPicker.swift
//  Grew
//
//  Created by daye on 10/16/23.
//

import SwiftUI

struct ScheduleColorPicker: View {
    private let colors: [String] = ["7CDCAE", "50D093", "1FA866", "1A8C55", "157044", "0F5433", "0A3822", "051C11"]
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    @State private var colorIndex: Int = 0
    @Binding var colorPick: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("배너 색상").bold()
            LazyVGrid(columns: columns) {
                ForEach((0..<8), id: \.self) { i in
                    ZStack{
                        Color(hexCode: colors[i])
                            .frame(width: 70, height: 70)
                            .onTapGesture {
                                withAnimation(.easeIn){
                                    colorIndex = i
                                }
                                colorPick = colors[colorIndex]                            }
                            .padding(3)
                        
                        if(colorIndex == i){
                            Image(systemName: "checkmark")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            
        }.padding(.top, 20)
            .onAppear{
                colorPick = colors[colorIndex]
            }
    }
}

#Preview {
    ScheduleColorPicker(colorPick: .constant("7CDCAE"))
}
