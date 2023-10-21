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
    @StateObject var userViewModel = UserViewModel()
    @StateObject var chatStore = ChatStore()
    @StateObject var messageStore = MessageStore()
    @StateObject private var vm = LaunchViewModel()
    @EnvironmentObject private var grewViewModel : GrewViewModel
    
    var body: some View {
        if vm.authuser == nil {
            AuthStartView()
        } else {
            MainTabView()
                .environmentObject(grewViewModel)
                .environmentObject(UserViewModel())
                .environmentObject(chatStore)
                .environmentObject(messageStore)
                .onAppear {
                    grewViewModel.fetchJsonData()
                }
        }
    }
}

#Preview {
    LaunchView()
}
