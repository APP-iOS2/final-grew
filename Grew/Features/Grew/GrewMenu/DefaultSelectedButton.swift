//
//  DefaultSelectedButton.swift
//  Grew
//
//  Created by 마경미 on 22.10.23.
//

import SwiftUI

struct DefaultSelectedButton: View {
    @Binding var isSelected: Bool
    
    var isBig: Bool = false
    var action: () -> ()
    var text: String

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .font(.b2_R)
        })
        .frame(height: isBig ? 44 : 32)
        .foregroundStyle(isSelected ? Color.white : Color.DarkGray1)
        .padding(.horizontal, isBig ? 20 :24)
        .background(isSelected ? Color.Sub : Color.BackgroundGray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    DefaultSelectedButton(isSelected: .constant(false), action: {
        
    }, text: "남성")
}
