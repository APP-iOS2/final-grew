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

    var body: some View {
        Text(text)
            .padding(.horizontal, isSmall ? 12: 16)
            .padding(.vertical, isSmall ? 8 : 12)
//            .frame(width: isSmall ? 71 : 86, height: isSmall ? 30 : 41)
            .font(isSmall ? .c1_B : .b3_B)
            .foregroundStyle(Color.DarkGray2)
            .background(Color.BackgroundGray)
            .clipShape(.capsule)
    }
}

#Preview {
    CategoryView(text: "카테고리")
}
