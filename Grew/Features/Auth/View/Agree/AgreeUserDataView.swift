//
//  AgreeUserDataView.swift
//  Grew
//
//  Created by 김종찬 on 10/16/23.
//

import SwiftUI

struct AgreeUserDataView: View {
    
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
            Text("개인정보 처리방침")
            Spacer()
        }
    }
}

#Preview {
    AgreeUserDataView()
}
