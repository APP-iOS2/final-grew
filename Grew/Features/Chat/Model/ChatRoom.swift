//
//  Chatroom.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import Foundation

///채팅방
struct ChatRoom: Identifiable, Codable, Equatable {
    ///채팅방 ID
    /*@DocumentID*/ var id: String?
    ///채팅방 저장 이름
    var chatRoomName: String?
    ///참여자 UID 배열
    var members: [User]
    /// 채팅방 이름
    var roomName: String {
        chatRoomName ?? members.filter{$0 != UserService.shared.currentUser}[0].name 
    }
    ///마지막 메시지 (최신 메시지)
    var lastMessage: String?
    ///최신 업데이트 시간
    var timestamp: Date
    //guard let id = conversation.userIDs.filter({$0 != userID}).first else { return }
    //let isRead = conversation.isRead[userID] ?? true
}
