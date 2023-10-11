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
                action: action)
        )
    }
}
