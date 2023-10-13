//
//  ChatListView.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//

import SwiftUI


struct ChatListView: View {
    let filter: ChatSegment
    @EnvironmentObject var chatRoomStore: ChatRoomStore
    
    var body: some View {
        ScrollView{
            ForEach(chatRoomStore.chatRooms){ chatRoom in
                NavigationLink {
                    ChatDetailView(chatRoom: chatRoom)
                } label: {
                    ChatRoomCell(chatMessage: ChatMessage.dummyChat1)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                    .listSectionSeparator(.hidden)
            }
            .foregroundColor(.black)
        }
    }
}



struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ChatListView(filter: .group)
        }
    }
}
