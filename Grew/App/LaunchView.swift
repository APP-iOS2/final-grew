//
//  LaunchView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//

import FirebaseAuth
import SwiftUI

struct LaunchView: View {
    
    @StateObject var vm = LaunchVM()
    
    var body: some View {
        if vm.user == nil {
            AuthStartView()
        } else {
            MainTabView()
        }
    }
}

#Preview {
    LaunchView()
}
