//
//  LaunchView.swift
//  Grew
//
//  Created by 김종찬 on 10/5/23.
//
import FirebaseAuth
import SwiftUI

struct LaunchView: View {
    
    @StateObject var viewModel = LaunchViewModel()
    @StateObject var grewViewModel = GrewViewModel()
    @StateObject var userViewModel = UserViewModel()
    @StateObject var chatStore = ChatStore()
    @StateObject var messageStore = MessageStore()
    @StateObject var stumpStore = StumpStore()
    
    var body: some View {
        if viewModel.authuser == nil {
            AuthStartView()
        } else {
            MainTabView()
                .environmentObject(grewViewModel)
                .environmentObject(UserViewModel())
                .environmentObject(chatStore)
                .environmentObject(messageStore)
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
