//
//  View+Extensions.swift
//  Grew
//
//  Created by 김효석 on 10/10/23.
//

import SwiftUI

extension View {
    func grewAlert(
        isPresented: Binding<Bool>,
        title: String,
        secondButtonTitle: String?,
        secondButtonColor: Color?,
        secondButtonAction: (() -> Void)?,
        buttonTitle: String,
        buttonColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        return modifier(
            GrewAlertModifier(
                isPresented: isPresented,
                title: title,
                buttonTitle: buttonTitle,
                buttonColor: buttonColor,
                action: action,
                secondButtonTitle: secondButtonTitle,
                secondButtonColor: secondButtonColor,
                secondButtonAction: secondButtonAction
            )
        )
    }
    func grewButtonModifier(
        width: CGFloat,
        height: CGFloat,
        buttonColor: Color,
        font: Font,
        fontColor: Color,
        cornerRadius: CGFloat) -> some View {
            modifier(
                GrewButtonModifier(
                    width: width,
                    height: height,
                    buttonColor: buttonColor,
                    font: font,
                    fontColor: fontColor,
                    cornerRadius: cornerRadius))
        }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func endTextEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}


extension View {
    func navigationBarBackground(_ background: Color = .orange) -> some View {
        return self
            .modifier(ColoredNavigationBar(background: background))
    }
}

struct ColoredNavigationBar: ViewModifier {
    var background: Color
    
    init(background: Color) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        self.background = background
    }
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(
                background,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
