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
            ScrollView(.horizontal) {
                HStack {
                    ForEach(mainCategories) { mainCategory in
                        CategoryView(isSmall: false, text: mainCategory.categoryForKorean)
                    }
                }
            }
        }
    }
}

#Preview {
    MainMapOverTopView()
}
