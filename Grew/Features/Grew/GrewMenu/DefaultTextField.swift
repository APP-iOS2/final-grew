//
//  DefaultTextField.swift
//  Grew
//
//  Created by 마경미 on 23.10.23.
//

import SwiftUI

struct DefaultTextField: View {
    var height: CGFloat = 44
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    init(height: CGFloat = 44, placeholder: String, keyboardType: UIKeyboardType = .default, text: Binding<String>, isFocused: Bool = false) {
        self.height = height
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self._text = text
        self.isFocused = isFocused
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? Color.Main : Color.BackgroundGray, lineWidth: 1)
                .background(Color.BackgroundGray)
            TextField(placeholder, text: $text, axis: .vertical)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .font(.b2_R)
                .foregroundColor(.DarkGray1)
                .focused($isFocused)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .lineLimit(height > 44 ? 1...10 : 0...1)
            if isFocused && height <= 44 {
                HStack {
                    Spacer()
                    Button(action: {
                        text = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.Main)
                    })
                    .padding(.trailing, 20)
                }
            }
        }
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


#Preview {
    DefaultTextField(placeholder: "예시", text: .constant("예시"))
}
