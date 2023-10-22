//
//  DefaultPlusButton.swift
//  Grew
//
//  Created by 마경미 on 22.10.23.
//

import SwiftUI

struct DefaultPlusButton: View {
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
        .frame(height: 44)
        .foregroundStyle(Color.DarkGray1)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.DarkGray1, lineWidth: 2)
        )
    }
}

#Preview {
    DefaultPlusButton(action: {
        
    }, text: "+ 추가하기")
}
