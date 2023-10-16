//
//  GrewButtonModifier.swift
//  Grew
//
//  Created by 윤진영 on 10/11/23.
//

import SwiftUI

struct GrewButtonModifier: ViewModifier {
    
    var width: CGFloat
    var height: CGFloat
    var buttonColor: Color
    var font: Font
    var fontColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: width, height: height)
                .tint(buttonColor)
            content
                .font(font)
                .foregroundColor(fontColor)
        }
    }
}

extension View {
    func grewButtonModifier(width: CGFloat, height: CGFloat, buttonColor: Color, font: Font, fontColor: Color) -> some View {
        modifier(GrewButtonModifier(width: width, height: height, buttonColor: buttonColor, font: font, fontColor: fontColor))
    }
}
