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
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: width, height: height)
                .tint(buttonColor)
            content
                .font(font)
                .foregroundColor(fontColor)
        }
    }
}

