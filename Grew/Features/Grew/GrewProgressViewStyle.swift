//
//  GroupProgressViewStyle.swift
//  CircleRecruitment
//
//  Created by KangHo Kim on 2023/09/25.
//

import SwiftUI

extension Color {
    static let grewMainColor = Color(hex: 0x25C578)
}
private let grewColorExample = Color(#colorLiteral(red: 0.145, green: 0.773, blue: 0.471, alpha: 1)) // #25c578

struct GrewProgressViewStyle: ProgressViewStyle {
    @Binding var value: Double
    @Binding var total: Double
    
    func makeBody(configuration: Configuration) -> some View {
        let offset = CGFloat(value) / 100
        return GeometryReader { geometry in
            VStack(spacing: -1) {
                HStack {
                    if value == 100 {
                        Text("")
                    } else {
                        Text(Image(systemName: "leaf.fill"))
                            .scaleEffect(x: -1, y: 1, anchor: .center)
                            .frame(width: CGFloat(geometry.size.width * offset + 15), alignment: .bottomTrailing)
                            .animation(.easeOut(duration: 0.12), value: value)
                    }
                    Spacer()
                    Image(systemName: "tree.fill")
                        .symbolRenderingMode(.multicolor)
                        .foregroundStyle(Color(red: 0.145, green: 0.773, blue: 0.471), .brown)
                        .frame(alignment: .bottomTrailing)
                }
                .foregroundColor(.grewMainColor)
                .padding(.horizontal, 1)
                ProgressView(configuration)
                    .accentColor(.grewMainColor)
                    .animation(.easeOut(duration: 1), value: value)
            }
        }
    }
}
