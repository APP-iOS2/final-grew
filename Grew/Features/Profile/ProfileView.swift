//
//  ProfileView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/21.
//

import SwiftUI

struct ProfileView: View {
    var grewViewModel: GrewViewModel
   
    @State private var isMyProfile: Bool = true
    @State var selectedGroup: String = "내 모임"
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ProfileHeaderView(name: UserStore.shared.currentUser?.nickName ?? "",
                                  statusMessage: UserStore.shared.currentUser?.introduce ?? "")
                
                UserContentListView()
            }
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
//                    ToolbarItem {
//                        NavigationLink {
////                            SettingView()
//                        } label: {
//                            Image(systemName: "paperplane.fill")
//                        }
//                        .foregroundColor(.black)
//                    }

//                } else {
//                    
//                }
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
        ProfileView(grewViewModel: GrewViewModel())
            .environmentObject(UserStore())
    }
}
