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
        VStack{
            switch filter {
            case .group:
                if chatStore.groupChatRooms.isEmpty {
                    isEmptyGroup
                } else {
                    ScrollView {
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
                    }
                }
            case .personal:
                if chatStore.personalChatRooms.isEmpty {
                    isEmptyGroup
                } else {
                    ScrollView {
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
            }
        }
    }
    
    private var isEmptyGroup: some View {
        VStack {
            Spacer()
            switch filter {
            case .personal:
                Text("참여 중인 개인 채팅방이 없습니다.")
                    .font(.h2_B)
                Image(systemName: "bubble.left.and.text.bubble.right.fill")
                    .font(.title2)
            case .group:
                Text("참여 중인 그루 채팅방이 없습니다.")
                    .font(.h2_B)
                Image(systemName: "bubble.left.and.text.bubble.right.fill")
                    .font(.title2)
            }
            Spacer()
        }
    }
}
