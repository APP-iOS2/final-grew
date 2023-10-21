//
//  LaunchView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//
import FirebaseAuth
import SwiftUI

struct LaunchView: View {
 
    @StateObject private var vm = LaunchViewModel()
    @StateObject private var grewViewModel = GrewViewModel()
    @StateObject private var appState = AppState()
    @StateObject var stumpStore = StumpStore()
    
    var body: some View {
        if vm.authuser == nil {
            AuthStartView()
        } else {
            MainTabView()
                .environmentObject(grewViewModel)
                .environmentObject(AppState())
                .environmentObject(stumpStore)
                .onAppear {
                    grewViewModel.fetchJsonData()
                }
        }
    }
}

#Preview {
    LaunchView()
}
