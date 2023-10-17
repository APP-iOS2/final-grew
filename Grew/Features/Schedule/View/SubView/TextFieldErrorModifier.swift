//
//  TextFieldErrorModifier.swift
//  Grew
//
//  Created by daye on 10/17/23.
//

import SwiftUI

struct TextFieldErrorModifier: ViewModifier {
    
    @Binding var isError: Bool
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isError ? Color(hexCode: "F05650") : Color("customGray") )
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("customGray"))
                    )
            )
    }
}
