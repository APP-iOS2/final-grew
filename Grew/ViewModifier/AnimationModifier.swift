//
//  AnimationModifier.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/05.
//

import SwiftUI

struct AnimationModifier: ViewModifier {
    var isAnimating: Bool
    var delay: TimeInterval
    
    func body(content: Content) -> some View {
        content
            .offset(y: isAnimating ? 0 : 20)
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 0.8).delay(delay), value: isAnimating)
    }
}

extension View {
    func animationModifier(isAnimating: Bool, delay: TimeInterval) -> some View {
        modifier(AnimationModifier(isAnimating: isAnimating, delay: delay))
    }
}
