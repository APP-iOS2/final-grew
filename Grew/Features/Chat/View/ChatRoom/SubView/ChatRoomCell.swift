//
//  ChatRoomCell.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//

import SwiftUI

struct ChatRoomCell: View {
    let chatRoom: ChatRoom
    var chatGrewInfo: Grew?
    
    // 나를 제외한 유저 목록
    let targetUserInfos: [User]
    @EnvironmentObject private var chatStore: ChatStore
    
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
        HStack{
            // 그루 단톡방 이미지
            if let chatGrewInfo {
                CircularProfileImageView(
                    chatMessage: nil, 
                    url: chatGrewInfo.imageURL, 
                    imagesize: .chatRoomList)
            } else {
                CircularProfileImageView(
                    chatMessage: nil,
                    url: targetUserInfos[safe: 0]?.userImageURLString,
                    imagesize: .chatRoomList)
            }
                        
            VStack(alignment: .leading){
                Text(chatRoomName)
                    .bold()
                    .padding(0.005)
                Text(chatRoom.lastMessage)
                    .foregroundColor(.gray)
                    .font(.callout)
            }
            Spacer()
            
            VStack(alignment: .trailing){
                Text(chatRoom.lastMessageTimeString)
                    .foregroundColor(.gray)
                    .font(.callout)
                if let unCount = chatRoom.unreadMessageCount[UserStore.shared.currentUser!.id!] {
                    ZStack{
                        Text("\(unCount)")
                            .foregroundColor(.white)
                            .font(.caption)
                            .bold()
                            .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

/*
struct ChatRoomCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomCell()
    }
}
*/
