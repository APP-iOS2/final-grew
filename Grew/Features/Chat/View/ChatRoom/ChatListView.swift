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
                    NavigationLink {
                        ChatDetailView(
                            chatRoom: chatRoom,
                            targetUserInfos: chatStore.targetUserInfoDict[chatRoom.id] ?? []
                        )
                    } label: {
                        ChatRoomCell(
                            chatRoom: chatRoom,
                            chatGrewInfo: chatStore.targetGrewInfoDict[chatRoom.grewId ?? ""],
                            targetUserInfos: chatStore.targetUserInfoDict[chatRoom.id] ?? []
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .listSectionSeparator(.hidden)
                    .foregroundColor(.black)
                }
            case .personal:
                ForEach(chatStore.personalChatRooms){ chatRoom in
                    NavigationLink {
                        ChatDetailView(chatRoom: chatRoom, targetUserInfos: chatStore.targetUserInfoDict[chatRoom.id] ?? [])
                    } label: {
                        ChatRoomCell(
                            chatRoom: chatRoom,
                            targetUserInfos: chatStore.targetUserInfoDict[chatRoom.id] ?? []
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .listSectionSeparator(.hidden)
                    .foregroundColor(.black)
                }
            }
        }
        .task {
            if !chatStore.isDoneFetch {
                chatStore.addListener()
                await chatStore.fetchChatRooms()
            }
        }
    }
}
