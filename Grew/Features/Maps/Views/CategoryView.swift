//
//  CategoryView.swift
//  Grew
//
//  Created by 마경미 on 16.10.23.
//

import SwiftUI

struct CategoryView: View {
    var isSmall: Bool = false
    var text: String
    
    var handleAction: () -> Void

    var body: some View {
        Button(action: {
            
        }, label: {
            Text(text)
        }).padding(.horizontal, isSmall ? 12: 16)
            .padding(.vertical, isSmall ? 8 : 12)
            .font(isSmall ? .c1_B : .b3_B)
            .foregroundStyle(Color.DarkGray2)
            .background(Color.BackgroundGray)
            .clipShape(.capsule)
    }
}

#Preview {
    CategoryView(text: "카테고리", handleAction: {
        
    })
}
