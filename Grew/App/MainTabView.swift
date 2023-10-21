//
//  TabView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//
import SwiftUI

// TabView에 쓰일 각 뷰들을 enum으로 정의
enum SelectViews {
    case home, location, chat, profile
}

struct MainTabView: View {
    @State private var isNewGrewViewPresented = false
    @State private var selection: SelectViews = .home
    @EnvironmentObject private var userStore: UserStore
    @EnvironmentObject private var chatStore: ChatStore
    
    var body: some View {
        
        VStack {
            // 기능으로 사용하는 tabView와
            tabView
            // 버튼으로 사용하는 tabBar
            bottomTabs
        }
    }
}

extension MainTabView {
    
    var tabView: some View {
        
        TabView(selection: $selection) {
            
            HomeView()
                .tag(SelectViews.home)
                .setTabBarVisibility(isHidden: true)
            
            Text("내 주변")
                .tag(SelectViews.location)
            
            // Text("추가")
            
            MainChatView()
                .tag(SelectViews.chat)
          
            ProfileView(user: UserStore.shared.currentUser)
                .tag(SelectViews.profile)
        }

    }
    
    var bottomTabs: some View {
        
        HStack(spacing: 45) {
            
            /// 탭바 - 홈 버튼
            Button {
                self.selection = .home
            } label: {
                VStack {
                    Image(self.selection == .home ? "home_fill" : "home")
                    Text("홈")
                        .font(.c2_B)
                        .foregroundStyle(self.selection == .home ? Color.Main : Color.DarkGray1)
                }
            }
            
            /// 탭바 - 내 주변 버튼
            Button {
                self.selection = .location
            } label: {
                VStack {
                    Image(self.selection == .location ? "location_fill" : "location")
                    Text("내 주변")
                        .font(.c2_B)
                        .foregroundStyle(self.selection == .location ?  Color.Main : Color.DarkGray1)
                }
            }
            
            Button {
                isNewGrewViewPresented = true
            } label: {
                VStack {
                    Image("plus")
                        .foregroundStyle(Color.DarkGray1)
                    Text("내 주변")
                        .font(.c2_B)
                        .foregroundStyle(Color.DarkGray1)
                }
            }.fullScreenCover(isPresented: $isNewGrewViewPresented){
                NewGrewView()
            }
            
            
            /// 탭바 - 채팅 버튼
            Button {
                self.selection = .chat
            } label: {
                VStack {
                    Image(self.selection == .chat ? "chat_fill" : "chat")
                    Text("채팅")
                        .font(.c2_B)
                        .foregroundStyle(self.selection == .chat ?  Color.Main : Color.DarkGray1)
                }
            }
            
            /// 탭바 - 프로필 버튼
            Button {
                self.selection = .profile
            } label: {
                VStack {
                    Image(self.selection == .profile ? "profile_fill" : "profile")
                    Text("프로필")
                        .font(.c2_B)
                        .foregroundStyle(self.selection == .profile ?  Color.Main : Color.DarkGray1)
                }
            }
            
            
        }
        // 현재 사이즈 or 피그마의 90 사이즈
        //        .frame(height: 90)
    }
    
}

extension View {
    // 탭바 숨김 처리 여부 설정
    func setTabBarVisibility(isHidden: Bool) -> some View {
        background(TabBarAccessor(callback: { tabBar in
            tabBar.isHidden = true
        }))
    }
}


#Preview {
    MainTabView()
        .environmentObject(UserStore())
}
