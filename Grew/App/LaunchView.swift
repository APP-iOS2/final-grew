//
//  LaunchView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//
import FirebaseAuth
import SwiftUI

struct LaunchView: View {
 
    @StateObject private var vm = LaunchVM()
    @StateObject private var grewViewModel = GrewViewModel()
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var appState = AppState()
    
    var body: some View {
        if viewModel.authuser == nil {
            AuthStartView()
        } else {
            MainTabView()
                .environmentObject(grewViewModel)
                .environmentObject(UserViewModel())
                .environmentObject(AppState())
                .onAppear {
                    grewViewModel.fetchJsonData()
                }
        }
    }
}

#Preview {
    LaunchView()
}
