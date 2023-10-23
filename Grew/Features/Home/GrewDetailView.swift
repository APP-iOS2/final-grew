//
//  GrewDetailView.swift
//  Grew
//
//  Created by 김효석 on 10/13/23.
//

import SwiftUI

enum GrewDetailFilter: Int, CaseIterable, Identifiable {
    
    case introduction
    case schedule
    case groot
    
    var title: String {
        switch self {
        case .introduction: return "소개"
        case .schedule: return "일정"
        case .groot: return "그루트"
        }
    }
    
    var id: Int { return self.rawValue }
}

struct GrewDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var grewViewModel: GrewViewModel
    @EnvironmentObject private var chatStore: ChatStore
    @State private var selectedFilter: GrewDetailFilter = .introduction
    @State private var isShowingJoinConfirmAlert: Bool = false
    @State private var isShowingJoinFinishAlert: Bool = false

    @State private var isLoading: Bool = false
    @State var detentHeight: CGFloat = 0
    
    @Namespace private var animation
    
    private let headerHeight: CGFloat = 180
    
    let grew: Grew
    
    var body: some View {
        VStack {
            ScrollView {
                makeHeaderImageView()
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        switch selectedFilter {
                        case .introduction:
                            GrewIntroductionView(grew: grew)
                        case .schedule:
                            ScheduleListView(gid: grew.id)
                        case .groot:
                            GrootListView(grew: grew)
                        }
                    } header: {
                        makeHeaderFilterView()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 18))
                            .foregroundStyle(Color.black)
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    makeToolbarButtons()
                }
            }
            .grewAlert(
                isPresented: $isShowingJoinFinishAlert,
                title: "\(grew.title)에 참여 완료!",
                secondButtonTitle: nil,
                secondButtonColor: nil,
                secondButtonAction: nil,
                buttonTitle: "확인",
                buttonColor: .Main,
                action: { }
            )
            .grewAlert(
                isPresented: $isShowingJoinConfirmAlert,
                title: "\(grew.title)에 참여하시겠습니까?",
                secondButtonTitle: "취소",
                secondButtonColor: .red,
                secondButtonAction: { },
                buttonTitle: "확인",
                buttonColor: .Main,
                action: {
                    if let userId = UserStore.shared.currentUser?.id {
                        grewViewModel.addGrewMember(grewId: grew.id, userId: userId)
                    }
                    isShowingJoinFinishAlert = true
                }
            )
            Divider()
                .padding(.bottom, 5)
            
            makeBottomButtons()
        }
        .onAppear(perform: {
            grewViewModel.selectedGrew = grew
        })
        .task {
            if !chatStore.isDoneFetch {
                chatStore.addListener()
                isLoading = true
                await chatStore.fetchChatRooms()
                isLoading = false
            }
        }
        .onDisappear {
            chatStore.removeListener()
            chatStore.isDoneFetch = false
        }
        .fullScreenCover(isPresented: $grewViewModel.showingSheet) {
            switch grewViewModel.sheetContent {
            case .grewEdit:
                GrewEditView()
            case .setting:
                GrewEditSheetView(grew: grew)
                    .readHeight()
                    .onPreferenceChange(HeightPreferenceKey.self) { height in
                        if let height {
                            self.detentHeight = height
                        }
                    }
                    .presentationDetents([.height(self.detentHeight)])
            default:
                fatalError("There is no View")
            }
        }
    }
    
}

// View 반환 함수
extension GrewDetailView {
    /// 헤더 이미지뷰
    private func makeHeaderImageView() -> some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: grew.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: geometry.size.width,
                        height: headerHeight + geometry.frame(in: .global).minY > 0 ? headerHeight + geometry.frame(in: .global).minY : 0
                    )
                    .clipped()
                    .offset(y: -geometry.frame(in: .global).minY)
                
            } placeholder: {
                ProgressView()
            }
        }
        .frame(height: headerHeight)
    }
    
    /// segment 필터 뷰
    private func makeHeaderFilterView() -> some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(GrewDetailFilter.allCases, id: \.self) { segment in
                    VStack {
                        Text(segment.title)
                            .font(.b2_B)
                            .foregroundColor(selectedFilter == segment ? .Main : Color(uiColor: .black))
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 4)
                            if selectedFilter == segment {
                                Capsule()
                                    .fill(Color.Main)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "item", in: animation)
                            }
                        }
                    }
                    .padding(.top)
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5)) {
                            selectedFilter = segment
                        }
                    }
                }
            }
            
            Rectangle()
                .frame(height: 8)
                .foregroundStyle(Color(hexCode: "ECECEC"))
        }
        .background(.white)
    }
    
    /// 툴바 버튼
    private func makeToolbarButtons() -> some View {
        HStack {
            // 모임장: 모임 삭제(alert), user 구조체
            // 모임원: 탈퇴하기
            Button {
                grewViewModel.sheetContent = .setting
                grewViewModel.showingSheet = true
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.black)
            }
        }
    }
    
    /// 하단 하트, 참여하기 버튼
    private func makeBottomButtons() -> some View {
        HStack(spacing: 20) {
            Button {
                
            } label: {
                Image(systemName: "heart")
                    .resizable()
                    .foregroundStyle(.red)
            }
            .frame(width: 27, height: 24.19)
            
            if let currentUserId = UserStore.shared.currentUser?.id {
                if grew.currentMembers.contains(currentUserId) {
                    NavigationLink {
//                        ChatDetailView(
//                            chatRoom: chatStore.groupChatRooms.first!,
//                            targetUserInfos: chatStore.targetUserInfoDict[chatStore.groupChatRooms.first!.id] ?? []
//                        )
                    } label: {
                        Text("채팅 참여하기")
                            .frame(width: 260, height: 44)
                    }
                    .grewButtonModifier(
                        width: 260,
                        height: 44,
                        buttonColor: .Main,
                        font: .b1_B,
                        fontColor: .white,
                        cornerRadius: 8
                    )
                } else {
                    Button {
                        isShowingJoinConfirmAlert = true
                    } label: {
                        Text("그루 참여하기")
                            .frame(width: 260, height: 44)
                    }
                    .grewButtonModifier(
                        width: 260,
                        height: 44,
                        buttonColor: .Main,
                        font: .b1_B,
                        fontColor: .white,
                        cornerRadius: 8
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}



#Preview {
    NavigationStack {
        GrewDetailView(
            grew: Grew(
                id: "id",
                categoryIndex: "게임/오락",
                categorysubIndex: "보드게임",
                title: "멋쟁이 보드게임",
                description: "안녕하세요!\n보드게임을 잘 해야 한다 ❌\n보드게임을 좋아한다 🅾️ \n\n즐겁게 보드게임을 함께 할 친구들이 필요하다면,\n<멋쟁이 보드게임> 그루에 참여하세요!\n\n매주 수요일마다 모이는 정기 모임과\n자유롭게 모이는 번개 모임을 통해\n많은 즐거운 추억을 쌓을 수 있어요 ☺️\n\n",
                imageURL: "https://images.unsplash.com/photo-1696757020926-d627b01c41cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=900&q=60",
                isOnline: false,
                location: "서울",
                gender: .any,
                minimumAge: 20,
                maximumAge: 40,
                maximumMembers: 8,
                currentMembers: ["id1", "id2"],
                isNeedFee: false,
                fee: 0
            )
        )
    }
    .environmentObject(GrewViewModel())
}
