//
//  AuthCompleteView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//
// 로그인 확인용

import SwiftUI

struct AuthCompleteView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Complete")
                    .font(.headline)
                Text("\(UserDefaults.standard.string(forKey: "SignType") ?? "")")
                Text("\(UserStore.shared.currentUser?.nickName ?? "")")
                Text("\(UserStore.shared.currentUser?.email ?? "")")
                Text("\(UserStore.shared.currentUser?.dob ?? "")")
                Text("\(UserStore.shared.currentUser?.gender ?? "")")
                Button {
                    AuthStore.shared.signOut()
                } label: {
                    Text("Logout")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    AuthCompleteView()
}
