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
    @EnvironmentObject private var chatStore: ChatStore
    @EnvironmentObject var grewViewModel: GrewViewModel
    @StateObject var homeRouter: HomeRouter = HomeRouter()
    @StateObject var profileRouter: ProfileRouter = ProfileRouter()
    
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
            NavigationStack(path: $homeRouter.homePath) {
                HomeView()
                    .setTabBarVisibility(isHidden: true)
                    .navigationDestination(for: HomeRouter.HomeRoute.self, destination: { home in
                        switch home {
//                        case .alert:
                            
                        case .category(let grewList, let secondCategory):
                            CategoryDetailView(grewList: grewList, secondCategory: secondCategory)
                                .navigationBarBackButtonHidden()
                        case .grewDetail(let grew):
                            GrewDetailView(grew: grew)
                                .navigationBarBackButtonHidden()
                        case .search:
                            GrewSearchView()
                                .navigationBarBackButtonHidden()
                        }
                    })
            }
            .tag(SelectViews.home)
            .environmentObject(homeRouter)
                
            
            MapView()
                .tag(SelectViews.location)
            
            // Text("추가")
            
            MainChatView()
                .tag(SelectViews.chat)
            
            NavigationStack(path: $profileRouter.profilePath) {
                ProfileView(selection: $selection, user: UserStore.shared.currentUser)
                    .navigationDestination(for: ProfileRouter.ProfileRoute.self, destination: { profile in
                        switch profile {
                        case .banner:
                            PurchaseAdsBannerView()
                                .navigationBarBackButtonHidden()
                        case .edit(let user):
                            EditProfileView(user: user)
                        case .setting:
                            SettingView()
                                .navigationBarBackButtonHidden()
                        }
                    })
            }
            .tag(SelectViews.profile)
            .environmentObject(profileRouter)
        }

    }
    
    var bottomTabs: some View {
        
        HStack(spacing: 45) {
            
            /// 탭바 - 홈 버튼
            Button {
                if selection == .home {
                    homeRouter.reset()
                }
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
                if selection == .profile {
                    profileRouter.reset()
                }
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
        .frame(height: 60)
        .border(height: 0.5, edges: [.top], color: .LightGray1)
    }
    
}

extension View {
    // 탭바 숨김 처리 여부 설정
    func setTabBarVisibility(isHidden: Bool) -> some View {
        background(TabBarAccessor(callback: { tabBar in
            tabBar.isHidden = true
        }))
    }
    
    func border(height: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(height: height, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var height: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return rect.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.height
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

#Preview {
    MainTabView()
}
