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
    @StateObject var grewViewModel = GrewViewModel()
    @StateObject var userViewModel = UserViewModel()
    @StateObject var chatStore = ChatStore()
    @StateObject var messageStore = MessageStore()
    
    var body: some View {
        if vm.user == nil {
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
