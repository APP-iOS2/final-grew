//
//  RemoveAdsView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/18.
//

import SwiftUI

struct PurchaseAdsBannerView: View {
    var body: some View {
        ZStack {
            Image("grewbanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    PurchaseAdsBannerView()
}
