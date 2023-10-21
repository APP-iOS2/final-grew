//
//  MainMapOverTopView.swift
//  Grew
//
//  Created by 마경미 on 10.10.23.
//

import SwiftUI

struct MainMapOverTopView: View {
    @EnvironmentObject var viewModel: MapStore
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.mainCategories) { mainCategory in
                        CategoryView(isSmall: false, category: mainCategory, handleAction: {
                            viewModel.toggleCategory(category: mainCategory)
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
