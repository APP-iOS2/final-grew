//
//  ChatListView.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//

import SwiftUI

struct ChatListView: View {
    let filter: ChatSegment
    @EnvironmentObject private var chatStore: ChatStore
    
    var body: some View {
        ScrollView {
            switch filter {
            case .group:
                ForEach(chatStore.groupChatRooms){ chatRoom in
                    VStack {
                        Text("\(chatRoom.chatRoomName ?? "nil")")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .listSectionSeparator(.hidden)
                }
            case .personal:
                ForEach(chatStore.personalChatRooms){ chatRoom in
                    VStack {
                        Text("\(chatRoom.chatRoomName ?? "nils")")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .listSectionSeparator(.hidden)
                }
            }
            
            Button {
                Task {
                    guard let currentUser = UserStore.shared.currentUser else { return }
                    var chatroom = ChatRoom(id: UUID().uuidString, chatRoomName: "나무심기", members: [currentUser.id ?? ""], createdDate: Date(), lastMessage: "\(currentUser.nickName)님이 입장하셨습니다.", lastMessageDate: Date(), unreadMessageCount: [:])
                    await chatStore.addChatRoom(chatroom)
                    chatroom = ChatRoom(id: UUID().uuidString, members: [currentUser.id ?? ""], createdDate: Date(), lastMessage: "\(currentUser.nickName)님이 입장하셨습니다.", lastMessageDate: Date(), unreadMessageCount: [:])
                    await chatStore.addChatRoom(chatroom)
                    chatroom = ChatRoom(id: UUID().uuidString, chatRoomName: "라즈베리 크로넛 마시따", members: [currentUser.id ?? ""], createdDate: Date(), lastMessage: "\(currentUser.nickName)님이 입장하셨습니다.", lastMessageDate: Date(), unreadMessageCount: [:])
                    await chatStore.addChatRoom(chatroom)
                    chatroom = ChatRoom(id: UUID().uuidString, chatRoomName: "히힛", members: [currentUser.id ?? ""], createdDate: Date(), lastMessage: "\(currentUser.nickName)님이 입장하셨습니다.", lastMessageDate: Date(), unreadMessageCount: [:])
                    await chatStore.addChatRoom(chatroom)
                    chatroom = ChatRoom(id: UUID().uuidString, chatRoomName: "엽떡 탐방", members: [currentUser.id ?? ""], createdDate: Date(), lastMessage: "\(currentUser.nickName)님이 입장하셨습니다.", lastMessageDate: Date(), unreadMessageCount: [:])
                    await chatStore.addChatRoom(chatroom)
                    chatroom = ChatRoom(id: UUID().uuidString, members: [currentUser.id ?? ""], createdDate: Date(), lastMessage: "\(currentUser.nickName)님이 입장하셨습니다.", lastMessageDate: Date(), unreadMessageCount: [:])
                    await chatStore.addChatRoom(chatroom)
                }
            } label: {
                Text("채팅방 추가")
            }

        }
        .task {
            if !chatStore.isDoneFetch {
                chatStore.addListener()
                await chatStore.fetchChatRooms()
            }
        }
    }
    
    private var listCell: some View {
        /* ForEach(chatStore.chatRooms){ chatRoom in
         NavigationLink {
         ChatDetailView(chatRoom: chatRoom)
         } label: {
         ChatRoomCell(chatMessage: ChatMessage.dummyChat1)
         }
         .padding(.horizontal, 20)
         .padding(.vertical, 15)
         .listSectionSeparator(.hidden)
         }
         .foregroundColor(.black) */
        Text("")
    }
}

#Preview {
    ChatListView(filter: .group)
}