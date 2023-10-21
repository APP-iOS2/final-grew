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
    @State private var selectedFilter: ProfileThreadFilter = .myGroup
    
    let user: User?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                headerView()
                
                LazyVStack(pinnedViews: [.sectionHeaders])  {
                    Section {
                        switch selectedFilter {
                        case .myGroup:
                            MyGroupView()
                                .background(Color.white)
                        case .myGroupSchedule:
                            MyGroupScheduleView()
                                .background(Color.white)
                        case .savedGrew:
                            SavedGrewView()
                                .background(Color.white)
                        }
                    } header: {
                        UserContentListView( selectedFilter: $selectedFilter)
                            .padding(.horizontal, 10)
                    }
                }
            }
            .background(Color.white)
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
                                .foregroundStyle(Color.white)
                        }
                        .foregroundColor(.black)
                    }
                    
                }
            }
            .navigationBarBackground(.Main)
            .frame(maxWidth: .infinity, alignment: .leading)
            .coordinateSpace(name: "SCROLL")
//            .ignoresSafeArea(.container, edges: .vertical)
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
        .background(alignment: .bottom) {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 475)
                .foregroundStyle(Color.white)
                .ignoresSafeArea()
                .offset(y: 100)
        }
        .background(Color.Main)
    }
    // 1:1 메시지 생성
    private func startMessage() {
        
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        var backgroundHeight: CGFloat {
            //        let count = CGFloat(ProfileThreadFilter.allCases.count)
            //        return UIScreen.main.bounds.height / count - 100
            return UIScreen.main.bounds.height / 5
        }
        GeometryReader { proxy in
            
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = (size.height + minY)
            
            ZStack(alignment: .bottom) {
                RoundSpecificCorners()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    CircleImage()
                    
                    HStack(alignment: .bottom){
                        
                        VStack(alignment: .leading){
                            Text(user?.nickName ?? "테스트")
                                .font(.b1_R)
                            Text(user?.introduce ?? "안녕하세요 \(user?.nickName ?? "테스트")입니다.")
                                .font(.b3_L)
                                .padding(.vertical, 5)
                        }
                        Spacer()
                        
                        NavigationLink {
                            EditProfileView(
                                user: user!
                            )
                        } label: {
                            Text("프로필 수정")
                                .font(.c1_B)
                                .background(RoundedRectangle(cornerRadius: 7)
                                    .foregroundColor(.LightGray2)
                                    .frame(width: 90, height: 28)
                                )
                        }
                        .padding(10)
                        .foregroundColor(.white)
                    }.padding(10)
                        .padding(.horizontal, 10)
                    
                    Divider()
                }
                .offset(y: -minY)
            }
            .background(Color.grewMainColor)
        }
        .frame(height: UIScreen.main.bounds.height / 3)
    }
    
    
}

#Preview {
    NavigationStack{
        ProfileView(user: User.dummyUser)
    }
}
