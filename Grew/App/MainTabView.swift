//
//  TabView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct MainTabView: View {
    @State private var isNewGrewViewPresented = false
    
    var body: some View {
        NavigationStack {
            TabView {
                
                Text("홈")
                    .tabItem {
                        Image(systemName: "house")
                        Text("홈")
                    }
                
                Text("내 주변")
                    .tabItem {
                        Image(systemName: "location.fill")
                        Text("내 주변")
                    }
                NewGrewView()
                    .tabItem {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                    }
                    .onAppear {
                        isNewGrewViewPresented = true
                    }
                    .fullScreenCover(isPresented: $isNewGrewViewPresented){
                        NewGrewView()
                    }
                
                Text("채팅")
                    .tabItem {
                        Image(systemName: "ellipsis.message")
                        Text("채팅")
                    }
                
                Text("프로필")
                    .tabItem {
                        Image(systemName: "person")
                        Text("프로필")
                    }
            }
            .toolbar(.hidden)
        }
    }
}
#Preview {
    MainTabView()
}
