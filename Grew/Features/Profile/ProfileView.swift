//
//  ProfileView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var grewViewModel: GrewViewModel
    @EnvironmentObject private var chatStore: ChatStore
    @EnvironmentObject private var messageStore: MessageStore
    
    @State private var isMessageAlert: Bool = false
    @State private var selectedGroup: String = "내 모임"
    
    let user: User?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ProfileHeaderView(
                    user: user ?? User.dummyUser
                )
                
                UserContentListView()
                    .padding(.horizontal, 10)
            }
            .toolbar {
                if user == UserStore.shared.currentUser {
                    ToolbarItem {
                        NavigationLink {
                            SettingView()
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                        .foregroundColor(.black)
                    }
                } else {
                    ToolbarItem {
                        Button {
                            //                            SettingView()
                        } label: {
                            Image(systemName: "paperplane.fill")
                        }
                        .foregroundColor(.black)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .alert("확인", isPresented: $isMessageAlert) {
                Button("취소", role: .cancel) {}
                Button("확인", role: .destructive) {
                        startMessage()
                        isMessageAlert = false
                }
            } message: {
                Text("1:1 채팅방으로 이동합니다.")
            }
        }
    }
    // 1:1 메시지 생성
    private func startMessage() {
        
    }
}

#Preview {
    NavigationStack {
        ProfileView(user: UserStore.shared.currentUser!)
    }
}
