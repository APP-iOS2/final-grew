//
//  DefaultClickButton.swift
//  Grew
//
//  Created by 마경미 on 22.10.23.
//

import SwiftUI

struct DefaultClickButton: View {
    var action: () -> ()
    @Binding var text: String
    var placeholder: String?

    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Text(text)
                    .font(.b2_R)
                    .padding(.horizontal)
                Spacer()
            }
        })
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .foregroundStyle(placeholder != nil ? Color.init(hexCode: "c4c4c4") : Color.DarkGray1)
        .background(Color.BackgroundGray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    DefaultClickButton(action: {
        
    }, text: .constant("선택"))
}
