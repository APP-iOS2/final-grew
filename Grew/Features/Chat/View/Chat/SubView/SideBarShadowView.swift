//
//  SideBarShadowView.swift
//  Grew
//
//  Created by cha_nyeong on 10/13/23.
//

import SwiftUI

struct SideBarShadowView: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100)
            .foregroundColor(Color.black.opacity(0.3))
            .ignoresSafeArea(.all, edges: .all)
            .onTapGesture {
                withAnimation(.easeInOut){
                    isMenuOpen = false
                }
            }
    }
}

#Preview {
    SideBarShadowView(isMenuOpen: .constant(false))
}
