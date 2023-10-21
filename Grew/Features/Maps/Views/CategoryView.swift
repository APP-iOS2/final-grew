//
//  CategoryView.swift
//  Grew
//
//  Created by 마경미 on 16.10.23.
//

import SwiftUI

struct CategoryView: View {
    var isSmall: Bool = false
    var isSelectable: Bool = true
    var category: GrewMainCategory
    
    @State var isSelected = false
    var handleAction: () -> Void

    var body: some View {
        Button(action: {
            handleAction()
            if isSelectable {
                isSelected.toggle()
            }
        }, label: {
            Text(category.categoryForKorean)
        }).padding(.horizontal, isSmall ? 12: 16)
            .padding(.vertical, isSmall ? 8 : 12)
            .font(isSmall ? .c1_B : .b3_B)
            .foregroundStyle(isSelected ? Color.white : Color.DarkGray2)
            .background(isSelected ? Color.Sub : Color.BackgroundGray)
            .clipShape(.capsule)
    }
}

#Preview {
    CategoryView(category: .activity, handleAction: {
        
    })
}
