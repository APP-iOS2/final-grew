//
//  TabView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//
import SwiftUI

enum SelectViews {
    case home, location, chat, profile
}


struct MainTabView: View {
    @State private var isNewGrewViewPresented = false
    @State private var selection: SelectViews = .home
    @EnvironmentObject var userViewModel: UserViewModel
    
    init() {
        UITabBar.appearance().backgroundColor = .red
    }
    
    var body: some View {
        NavigationStack {
            tabView
            //            .toolbar(.hidden)
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
            
//            Text("추가")
            
            Text("채팅")
                .tag(SelectViews.chat)
            
            ProfileView(userStore: UserStore(), grewViewModel: GrewViewModel(), userViewModel: _userViewModel)
                .tag(SelectViews.profile)
        }
    }
    
    var bottomTabs: some View {
        
        HStack(spacing: 45) {
            
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
            
            
            Image("plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45)
                .foregroundStyle(Color.DarkGray1)
                .onTapGesture {
                    isNewGrewViewPresented = true
                }
                .fullScreenCover(isPresented: $isNewGrewViewPresented){
                    NewGrewView()
                }
            
            
            
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
        .environmentObject(UserViewModel())
}
