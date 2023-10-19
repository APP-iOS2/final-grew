//
//  MainMapOverTopView.swift
//  Grew
//
//  Created by 마경미 on 10.10.23.
//

import SwiftUI

struct MainMapOverTopView: View {
    private let mainCategories: [GrewMainCategory] = GrewMainCategory.allCases
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(mainCategories) { mainCategory in
                        CategoryView(isSmall: false, text: mainCategory.categoryForKorean, handleAction: {
                            
                        })
                    }
                }
            }.scrollIndicators(.hidden)
        }
        .frame(height: 100)
        .padding(.vertical, 20)
        .background(Color.white)
    }
}

#Preview {
    MainMapOverTopView()
}
