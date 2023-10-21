//
//  ProfileView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var grewViewModel: GrewViewModel
    @State private var isMyProfile: Bool = true
    @State private var selectedGroup: String = "내 모임"
    
    let user: User
    
    var body: some View {
        ScrollView {
            ProfileHeaderView(name: UserStore.shared.currentUser?.nickName ?? "",
                              statusMessage: UserStore.shared.currentUser?.introduce ?? "")
            UserContentListView()
                .padding(.horizontal, 10)
            
        }
        .ignoresSafeArea()
        .toolbar {
            //                if UserStore.shared.currentUser.id != UserStore.shared. {
            ToolbarItem {
                NavigationLink {
                    SettingView()
                } label: {
                    Image(systemName: "gearshape.fill")
                }
                .foregroundColor(.black)
            }
        }
        .onAppear {
            guard let currentUserId = UserDefaults.standard.string(forKey: "userId") else {
                return
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

#Preview {
    NavigationStack {
        ProfileView(user: UserStore.shared.currentUser!)
    }
}
