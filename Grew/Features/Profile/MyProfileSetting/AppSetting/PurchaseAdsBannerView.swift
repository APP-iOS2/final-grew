//
//  RemoveAdsView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/18.
//

import SwiftUI

struct PurchaseAdsBannerView: View {
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            Image("grewbanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .navigationTitle("광고 배너 구매")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.black)
                }
            }
        }
    }
}

#Preview {
    PurchaseAdsBannerView()
}
