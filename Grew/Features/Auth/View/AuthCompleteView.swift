//
//  AuthCompleteView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import SwiftUI

struct AuthCompleteView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Complete")
                    .font(.headline)
                
                Button {
                    AuthStore.shared.emailAuthSignOut()
                } label: {
                    Text("Logout")
                }
            }
        }
    }
}

#Preview {
    AuthCompleteView()
}
