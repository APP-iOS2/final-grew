//
//  GrewTextField.swift
//  Grew
//
//  Created by 김효석 on 10/11/23.
//

import SwiftUI

struct GrewTextField: View {
    @Binding var text: String
    /// 잘못된 입력값 여부
    let isWrongText: Bool
    /// Textfield 비활성화 여부
    let isTextfieldDisabled: Bool
    @FocusState var isTextFieldFocused: Bool
    
    let placeholderText: String
    let isSearchBar: Bool
    
    private var textFieldStrokeColor: Color {
        if isWrongText {
            return Color(hexCode: "F05650")
        }
        return isTextFieldFocused ? .Main : Color(hexCode: "f2f2f2")
    }
    
    var body: some View {
        HStack {
            HStack {
                if isSearchBar {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 5)
                }
                
                TextField(placeholderText, text: $text)
                    .submitLabel(.search)
                    .focused($isTextFieldFocused)
                    .font(.b2_R)
                    .disabled(isTextfieldDisabled)
                    .padding(.leading, isSearchBar ? 0 : 10)
                    .textInputAutocapitalization(.never)
                
                if !text.isEmpty && isTextFieldFocused {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(isWrongText ? .Error : .Main)
                    }
                    .padding(.trailing, 16)
                }
            }
            .frame(height: 44)
            
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(textFieldStrokeColor)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(isTextfieldDisabled ? Color.LightGray2: Color.BackgroundGray)
                    )
            )
            
            if isSearchBar && isTextFieldFocused {
                Button {
                    isTextFieldFocused = false
                } label: {
                    Text("취소")
                        .font(.b2_R)
                }
            }
        }
    }
}

#Preview {
    GrewTextField(
        text: .constant(""),
        isWrongText: false,
        isTextfieldDisabled: false,
        isTextFieldFocused: FocusState(),
        placeholderText: "검색어를 입력하세요.",
        isSearchBar: true
    )
}
