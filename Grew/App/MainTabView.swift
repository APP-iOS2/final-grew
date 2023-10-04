//
//  TabView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct MainTabView: View {
    @State private var isFullScreenCoverPresented = false
    
    var body: some View {
        
        TabView {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("내 주변")
                }
            
            Text("모임 추가")
                .tabItem {
                    Image(systemName: "plus.circle")
                        .font(.largeTitle)
                        
                }
                .onTapGesture {
                    isFullScreenCoverPresented = true
                }
                .fullScreenCover(isPresented: $isFullScreenCoverPresented) {
                    NewGrewView()
                }
            
            ChatView()
                .tabItem {
                    Image(systemName: "ellipsis.message")
                    Text("채팅")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("프로필")
                    
                }
        }
    }
}

#Preview {
    MainTabView()
}
