//
//  DefaultMainButton.swift
//  Grew
//
//  Created by 마경미 on 22.10.23.
//

import SwiftUI

struct DefaultMainButton: View {
    var action: () -> ()
    var text: String

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .font(.b1_B)
        })
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .foregroundStyle(Color.white)
        .background(Color.Main)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    DefaultMainButton(action: {
        
    }, text: "버튼")
}
