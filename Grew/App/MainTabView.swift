//
//  TabView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {
        
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
            
            Text("모임 추가")
                .tabItem {
                    Image(systemName: "plus.circle")
                        .font(.largeTitle)

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
    }
}

#Preview {
    MainTabView()
}
