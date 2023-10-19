//
//  ChatMessageListView.swift
//  Grew
//
//  Created by cha_nyeong on 10/13/23.
//

import SwiftUI

struct ChatMessageListView: View {
    @EnvironmentObject private var chatStore: ChatStore
    @EnvironmentObject private var messageStore: MessageStore
    
    let chatRoom: ChatRoom
    let targetUserInfos: [User]
    
    @Binding var isMenuOpen: Bool
    @Binding var x: CGFloat
    @Binding var unreadMessageIndex: Int?
    
    var chatRoomName: String {
        // 바꿀것
//        if let chatGrewInfo {
//            return chatGrewInfo.title
        if let chatRoomName = chatRoom.chatRoomName {
            return chatRoomName
        } else {
            if targetUserInfos.isEmpty {
                return UserStore.shared.currentUser!.nickName
            } else {
                return targetUserInfos[safe: 0]?.nickName ?? UserStore.shared.currentUser!.nickName
            }
        }
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView { 
                    ForEach(messageStore.messages.indices, id: \.self) { index in
                        MessageBubbles(chatMessage: messageStore.messages[index], 
                                       targetUserInfos: targetUserInfos)
                        .id(index == unreadMessageIndex ? "start" : "")
                        
                    }
                    //                        ForEach(chatStore.chatMessages) { chatMessage in
                    //                            MessageBubbles(chatMessage: chatMessage, selectedBubble: chatMessage.bubbleOwner)
                    Text("")
                        .id("bottom")
                }
                /*
                .onChange(of: unreadMessageIndex) { state, newState in
                    DispatchQueue.main.async {
                        Task {
                            if await getUnReadCount() == 0 {
                                proxy.scrollTo("bottom", anchor: .bottomTrailing)
                            } else {
                                proxy.scrollTo("start", anchor: .top)
                            }
                        }
                    }
                }
                .onChange(of: messageStore.isMessageAdded) { state, newState in
                    if messageStore.isFetchMessageDone {
                        proxy.scrollTo("bottom", anchor: .bottomTrailing)
                    }
                }
                .onTapGesture {
                    self.endTextEditing()
                }
                */
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isMenuOpen.toggle()
                            x = 0
                        }
                    }, label: {
                        if !isMenuOpen {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large).foregroundColor(Color.Main)
                        }
                    })
                }
            }
            .navigationTitle(isMenuOpen ? "" : chatRoomName)
            .navigationBarBackButtonHidden(isMenuOpen ? true : false)
            // 이거 쓰고 뷰 덮었을때 안밀려나는거 어케함 대체????????
            /*
             .safeAreaInset(edge: .bottom) {
             ChatBar
             .background(Color(.systemBackground).ignoresSafeArea())
             .shadow(radius: 0.5)
             }
             */
        }
        .task {
            let unreadMessageCount = await getUnReadCount()
            messageStore.addListener(chatRoomID: chatRoom.id)
            await messageStore.fetchMessages(chatID: chatRoom.id, unreadMessageCount: unreadMessageCount)
            
            unreadMessageIndex = messageStore.messages.count - unreadMessageCount
        }
    }
    private func getUnReadCount() async -> Int {
        let dict = await chatStore.getUnreadMessageDictionary(chatRoomID: chatRoom.id)
        let unreadCount = dict?[UserStore.shared.currentUser!.id! ] ?? 0
        return unreadCount
    }
}
//
//#Preview {
//    ChatMessageListView(isMenuOpen: .constant(true), x: .constant(450))
//}
