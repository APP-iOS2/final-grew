//
//  LaunchView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import FirebaseAuth
import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        if authStore.currentUser == nil {
            AuthStartView()
        } else {
            AuthCompleteView()
        }
    }
}

#Preview {
    LaunchView()
}
