//
//  AuthProgressBar.swift
//  Grew
//
//  Created by 김종찬 on 10/11/23.
//

import SwiftUI

extension Color {
    static let authColor = Color(hex: 0x25C578)
}

struct AuthProgressBar: ProgressViewStyle {
    @Binding var value: Double
    @Binding var total: Double
    
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .accentColor(.authColor)
            .animation(.easeOut(duration: 1), value: value)
    }
}
