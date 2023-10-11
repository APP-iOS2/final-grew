//
//  TabView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct MainTabView: View {
    @State private var isNewGrewViewPresented = false
    @State private var selection: Int = 0
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                
                HomeView()
                    .tabItem {
                        Image(selection == 0 ? "home_fill" : "home")
                        Text("홈")
                            .font(.c2_B)
                            .foregroundStyle(Color.DarkGray1)
                    }
                    .tag(0)

                Text("내 주변")
                    .tabItem {
                        Image(selection == 1 ? "location_fill" : "location")
                        Text("내 주변")
                            .font(.c2_B)
                            .foregroundStyle(Color.DarkGray1)
                    }
                    .tag(1)
                    
                    
                NewGrewView()
                    .tabItem {
                        Image(selection == 2 ? "plus_fill" : "plus")
                        Text("모임 생성")
                            .font(.c2_B)
                            .foregroundStyle(Color.DarkGray1)
                    }
                    .tag(2)
//                    .onAppear(perform: {
//
//                    })

                Text("채팅")
                    .tabItem {
                        Image(selection == 3 ? "chat_fill" : "chat")
                        Text("채팅")
                            .font(.c2_B)
                            .foregroundStyle(Color.DarkGray1)
                    }
                    .tag(3)

                Text("프로필")
                    .tabItem {
                        Image(selection == 4 ? "profile_fill" : "profile")
                        Text("프로필")
                            .font(.c2_B)
                            .foregroundStyle(Color.DarkGray1)
                    }
                    .tag(4)
            }
            .toolbar(.hidden)
            .tint(Color.Main)
            
        }
    }
}
#Preview {
    MainTabView()
}
