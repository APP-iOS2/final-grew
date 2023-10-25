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
    @EnvironmentObject private var messageStore: MessageStore
    
    @State private var selectedFilter: GrewDetailFilter = .introduction
    @State private var isShowingJoinConfirmAlert: Bool = false
    @State private var isShowingJoinFinishAlert: Bool = false
    
    @State var isShowingWithdrawConfirmAlert: Bool = false
    @State private var isShowingWithdrawFinishAlert: Bool = false
    
    @State private var isLoading: Bool = false
    @State var detentHeight: CGFloat = 0
    @State var heartState: Bool = false
    @State var isChatViewButton: Bool = false
    @State private var isScrollDown: Bool = true
    @State private var isGrewRemoved: Bool = false
    @Namespace private var animation
    
    private let headerHeight: CGFloat = 180
    
    let grew: Grew
    @State private var updatedGrew: Grew = Grew(
        categoryIndex: "",
        categorysubIndex: "",
        title: "",
        isOnline: false,
        gender: .any,
        minimumAge: 20,
        maximumAge: 20,
        maximumMembers: 10,
        isNeedFee: false
    )
    @State private var chatRoom: ChatRoom = ChatRoom(id: "", members: [], createdDate: Date(), lastMessage: "", lastMessageDate: Date(), unreadMessageCount: [:])
    
    var body: some View {
        VStack {
            ScrollView {
                makeHeaderImageView()
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        switch selectedFilter {
                        case .introduction:
                            GrewIntroductionView(grew: updatedGrew)
                        case .schedule:
                            ScheduleListView(grew: updatedGrew)
                        case .groot:
                            GrootListView(grew: updatedGrew)
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    makeToolbarButtons()
                }
            }
            .simultaneousGesture(
                DragGesture().onChanged { value in
                    isScrollDown = 0 < value.translation.height
                }
            )
            .toolbarBackground(isScrollDown ? .hidden : .visible, for: .navigationBar)
            .grewAlert(
                isPresented: $isShowingJoinFinishAlert,
                title: "\(updatedGrew.title)에 참여 완료!",
                secondButtonTitle: nil,
                secondButtonColor: nil,
                secondButtonAction: nil,
                buttonTitle: "확인",
                buttonColor: .Main,
                action: {
                    isChatViewButton = true
                }
            )
            .grewAlert(
                isPresented: $isShowingJoinConfirmAlert,
                title: "\(updatedGrew.title)에 참여하시겠습니까?",
                secondButtonTitle: "취소",
                secondButtonColor: .LightGray2,
                secondButtonAction: { },
                buttonTitle: "확인",
                buttonColor: .Main,
                action: {
                    Task {
                        if let userId = UserStore.shared.currentUser?.id {
                            grewViewModel.addGrewMember(grewId: updatedGrew.id, userId: userId)
                        }
                        await startMessage()
                        
                        isShowingJoinFinishAlert = true
                    }
                }
            )
            Divider()
                .padding(.bottom, 5)
            
            makeBottomButtons()
        }
        .grewAlert(
            isPresented: $isShowingWithdrawConfirmAlert,
            title: "\(updatedGrew.title)에 탈퇴하시겠습니까?",
            secondButtonTitle: "취소",
            secondButtonColor: .LightGray2,
            secondButtonAction: { },
            buttonTitle: "탈퇴",
            buttonColor: .Error,
            action: {
                if let userId = UserStore.shared.currentUser?.id {
                    grewViewModel.withdrawGrewMember(grewId: updatedGrew.id, userId: userId)
                    isShowingWithdrawFinishAlert = true
                }
            }
        )
        .grewAlert(
            isPresented: $isShowingWithdrawFinishAlert,
            title: "\(updatedGrew.title)에 탈퇴 완료!",
            secondButtonTitle: nil,
            secondButtonColor: nil,
            secondButtonAction: nil,
            buttonTitle: "확인",
            buttonColor: .Main,
            action: {
                dismiss()
            }
        )
        .task {
            await chatStore.fetchChatRooms()
            chatRoom = await ChatStore.getChatRoomFromGID(gid: grew.id) ?? ChatRoom(id: "", members: [], createdDate: Date(), lastMessage: "", lastMessageDate: Date(), unreadMessageCount: [:])
        }
        .onAppear {
            updatedGrew = grew
            grewViewModel.selectedGrew = updatedGrew
            heartState = UserStore.shared.checkFavorit(gid: grew.id)
        }
        .onDisappear {
            chatStore.isDoneFetch = false
        }
        .fullScreenCover(isPresented: $grewViewModel.showingSheet) {
            switch grewViewModel.sheetContent {
            case .grewEdit:
                GrewEditView()
            case .setting:
                GrewEditSheetView(isShowingWithdrawConfirmAlert: $isShowingWithdrawConfirmAlert, isGrewRemoved: $isGrewRemoved, grew: updatedGrew)
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
        .navigationBarBackButtonHidden()
        .onChange(of: isGrewRemoved, { oldValue, newValue in
            dismiss()
        })
        .onReceive(grewViewModel.grewList.publisher, perform: { _ in
            if let updatedGrew = grewViewModel.grewList.first(where: { $0.id == grew.id }) {
                self.updatedGrew = updatedGrew
            }
        })
    }
    
}

// View 반환 함수
extension GrewDetailView {
    /// 헤더 이미지뷰
    private func makeHeaderImageView() -> some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: updatedGrew.imageURL)) { image in
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
                Image("logo")
                    .frame(
                        width: geometry.size.width,
                        height: headerHeight + geometry.frame(in: .global).minY > 0 ? headerHeight + geometry.frame(in: .global).minY : 0
                    )
                    .clipped()
                    .offset(y: -geometry.frame(in: .global).minY)
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
                if UserStore.shared.addFavorit(gid: updatedGrew.id) {
                    heartState = true
                } else {
                    heartState = false
                }
                grewViewModel.heartTapping(gid: updatedGrew.id)
            } label: {
                Image(systemName: heartState ? "heart.fill" : "heart")
                    .resizable()
                    .foregroundStyle(.red)
            }
            .frame(width: 27, height: 24.19)
            
            // 현재 사용자가 이미 그룹의 구성원인지 확인
            if let currentUserId = UserStore.shared.currentUser?.id {
                if updatedGrew.currentMembers.contains(currentUserId) && updatedGrew.currentMembers.count < updatedGrew.maximumMembers || isChatViewButton == true {
                    NavigationLink {
                        ChatDetailView(
                            chatRoom: chatRoom,
                            targetUserInfos: chatStore.targetUserInfoDict[chatRoom.id] ?? []
                        )
                    } label: {
                        Text("채팅 참여하기")
                            .grewButtonModifier(
                                width: 260,
                                height: 44,
                                buttonColor: .white,
                                font: .b1_B,
                                fontColor: .Main,
                                cornerRadius: 0
                            )
                    }
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.Main, lineWidth: 1)
                    )
                    .padding(.bottom, 2)
                } else {
                    Button {
                        if updatedGrew.currentMembers.count < updatedGrew.maximumMembers {
                            isShowingJoinConfirmAlert = true
                        }
                    } label: {
                        Text(updatedGrew.currentMembers.count >= updatedGrew.maximumMembers ? "그루 마감" : "그루 참여하기")
                            .grewButtonModifier(
                                width: 260,
                                height: 44,
                                buttonColor: updatedGrew.currentMembers.count >= updatedGrew.maximumMembers ? .LightGray2 : .Main,
                                font: .b1_B,
                                fontColor: .white,
                                cornerRadius: 8
                            )
                    }.disabled(updatedGrew.currentMembers.count >= updatedGrew.maximumMembers)
                        .padding(.bottom, 2)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func startMessage() async {
        // 1. gid에 해당하는 채팅방이 있는지 조회한다.
        guard let user = UserStore.shared.currentUser else {
            return
        }
        // 1-1. 있으면 있는 방을 조회 해서 chatRoom을 가져와서 인원을 넣는다.
        if let chatRoom = await ChatStore.getChatRoomFromGID(gid: grew.id) {
            var newChatRoom = chatRoom
            newChatRoom.members += [user.id!]
            newChatRoom.lastMessage =  "\(user.nickName)님이 입장하셨습니다."
            newChatRoom.lastMessageDate = .now
            
            await chatStore.updateChatRoomForExit(newChatRoom)
            
            // 2. 시스템 메시지를 추가한다.
            let newMessage = ChatMessage(text: "\(user.nickName)님이 입장하셨습니다.", uid: "system", userName: "시스템 메시지", isSystem: true)
            
            messageStore.addMessage(newMessage, chatRoomID: newChatRoom.id)
            
        } else {
            // 1-2. 없으면 새로운 방을 생성해서 인원을 넣는다.
            var newChatRoom: ChatRoom = ChatRoom(
                id: UUID().uuidString,
                grewId: grew.id,
                chatRoomName: grew.title,
                members: [user.id!],
                createdDate: Date(),
                lastMessage: "\(user.nickName)님이 입장하셨습니다.",
                lastMessageDate: Date(),
                unreadMessageCount: [:])
            await chatStore.addChatRoom(newChatRoom)
            
            // 2. 시스템 메시지를 추가한다.
            let newMessage = ChatMessage(text: "\(user.nickName)님이 입장하셨습니다.", uid: "system", userName: "시스템 메시지", isSystem: true)
            
            messageStore.addMessage(newMessage, chatRoomID: newChatRoom.id)
        }
        
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
    .environmentObject(ChatStore())
}
