//
//  GrewScheduleListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/10.
//

import SwiftUI

struct GrewScheduleListView: View {
    let grewList: [Grew]
    
    
    let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible())
    ]
    
    var body: some View {
        
        LazyVGrid(columns: columns) {
            ForEach(grewList) { grew in
                NavigationLink{
                    
                } label: {
                    GrewScheduleCell(grew: grew)
                        .padding(.horizontal, 6)
                        .padding(.bottom, 12)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal, 10)
        
    }
}

#Preview {
    GrewScheduleListView(grewList: [])
}
