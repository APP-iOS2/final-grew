//
//  ProfileView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/21.
//

import SwiftUI

struct ProfileView: View {
    var userStore: UserStore
    var grewViewModel: GrewViewModel
   
    @State private var isMyProfile: Bool = true
    @State var selectedGroup: String = "내 모임"
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ProfileHeaderView(
                    name: userViewModel.currentUser?.nickName ?? "",
                    statusMessage: userViewModel.currentUser?.introduce ?? "",
                    userStore: userStore,
                    userViewModel: userViewModel,
                    grewViewModel: grewViewModel)
                
                UserContentListView()
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .foregroundColor(.black)
                }
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
        ProfileView(userStore: UserStore(), grewViewModel: GrewViewModel())
            .environmentObject(UserViewModel())
    }
}
