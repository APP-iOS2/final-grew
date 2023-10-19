//
//  AgreeUseView.swift
//  Grew
//
//  Created by 김종찬 on 10/16/23.
//

import SwiftUI

struct AgreeUseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 25))
                        .foregroundStyle(Color.black)
                        .padding()
                }
                Spacer()
            }
            Spacer()
            Text("이용 약관")
            Spacer()
        }
    }
}

#Preview {
    AgreeUseView()
}
