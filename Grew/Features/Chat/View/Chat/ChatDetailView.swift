//
//  ChatDetailView.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/24.
//

import FirebaseAuth
import FirebaseStorage
import SwiftUI

struct ChatDetailView: View {
    // 채팅방 데이터
    let chatRoom: ChatRoom
    // 나를 제외한 유저 목록
    let targetUserInfos: [User]
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var chatStore: ChatStore
    @EnvironmentObject private var messageStore: MessageStore
    @Environment(\.presentationMode) var presentationMode
    
    @State private var groupDetailConfig = GroupDetailConfig()
    @State private var unreadMessageIndex: Int?
    @State private var isMenuOpen: Bool = false
    @State private var isExitButtonAlert = false
    @State private var x = UIScreen.main.bounds.width
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            // 채팅
            ChatMessageListView(
                chatRoom: chatRoom,
                targetUserInfos: targetUserInfos,
                groupDetailConfig: $groupDetailConfig,
                isMenuOpen: $isMenuOpen,
                x: $x,
                unreadMessageIndex: $unreadMessageIndex
            )
            .padding(.bottom, 20)
            .padding(.top, isMenuOpen ? 40 : 0)
            if isMenuOpen {
                SideBarShadowView(isMenuOpen: $isMenuOpen)
               
                ChatSideBar(isMenuOpen: $isMenuOpen, isExitButtonAlert: $isExitButtonAlert, chatRoomName: chatRoom.chatRoomName ?? "\(targetUserInfos[0].nickName)", targetUserInfos: targetUserInfos)
                    .offset(x: x)
                    .transition(isMenuOpen ? .move(edge: .trailing) : .identity)
                    .navigationBarHidden(isMenuOpen ? true : false)
                    .safeAreaPadding(.top, 50)
                    .gesture(DragGesture().onChanged({ (value) in
                        withAnimation(.easeInOut){
                            if value.translation.width < 0 {
                                x = width + value.translation.width
                            } else {
                                x = value.translation.width
                            }
                        }
                    }).onEnded({ (value) in
                        withAnimation(.easeInOut) {
                            if x < width / 2 {
                                x = 0
                            } else {
                                x = width
                                isMenuOpen = false
                            }
                        }
                    }))
            }
        }
       
        .alert("채팅방 나가기", isPresented: $isExitButtonAlert) {
            Button("취소", role: .cancel) {}
            Button("확인", role: .destructive) {
                isMenuOpen = false
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("채팅 내역이 모두 삭제됩니다.")
        }
        .confirmationDialog("Options", isPresented: $groupDetailConfig.showOptions, actions: {
            Button("Camera") {
                groupDetailConfig.sourceType = .camera
            }
            Button("Photo Library") {
                groupDetailConfig.sourceType = .photoLibrary
            }
        })
        .sheet(item: $groupDetailConfig.sourceType, content: { sourceType in
            ChatImagePicker(image: $groupDetailConfig.selectedImage, sourceType: sourceType)
        })
        //        .task {
        //            let unreadMessageCount = await getUnReadCount()
        //            messageStore.addListener(chatRoomID: chatRoom.id)
        //            await messageStore.fetchMessages(chatID: chatRoom.id, unreadMessageCount: unreadMessageCount)
        //            unreadMessageIndex = messageStore.messages.count - unreadMessageCount
        //        }
        .onDisappear {
            Task {
                //리스너 삭제
                messageStore.removeListener()
            }
        }
    }
    
    // 안 읽은 메시지 개수 구하기
    private func getUnReadCount() async -> Int {
        let dict = await chatStore.getUnreadMessageDictionary(chatRoomID: chatRoom.id)
        let unreadCount = dict?[UserStore.shared.currentUser!.id! ] ?? 0
        return unreadCount
    }
    
    // 읽지 않은 메시지 개수 0으로 초기화 + 업데이트 (채팅방 입장 시, 퇴장 시)
    private func clearUnreadMesageCount() async {
        var newChat: ChatRoom = chatRoom
        
        var newDict: [String : Int] = chatRoom.unreadMessageCount
        newDict[UserStore.shared.currentUser!.id!] = 0
        newChat.unreadMessageCount = newDict
        
        await chatStore.updateChatRoom(chatRoom)
    }
    
    @ViewBuilder
    private var shad: some View {
        if isMenuOpen {
            SideBarShadowView(isMenuOpen: $isMenuOpen)
        }
    }
    
  
}
