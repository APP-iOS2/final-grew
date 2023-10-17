//
//  Chatroom.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

/// 채팅방
struct ChatRoom: Identifiable, Codable, Equatable {
    /// 채팅방 ID
    @DocumentID var id: String?
    /// 채팅방 저장 이름
    var chatRoomName: String?
    /// 참여자 UID 배열
    var members: [String]
    /// 채팅방 생성일
    var createdDate: Date
    /// 마지막 메시지 (최신 메시지)
    var lastMessage: String?
    /// 최신 업데이트 시간
    var lastMessageDate: Date
    /// 안 읽은 메시지 개수 ( userID : 읽지 않은 메시지 개수)
    var unreadMessageCount: [String: Int]
    
}

// 연산 프로퍼티를 나누기 위한 익스텐션
extension ChatRoom {
    // 로그인한 유저를 제외한 나머지 채팅방의 인원을 반환하는 연산 프로퍼티
    var otherUserIDs: [String] {
        if let currentUser = UserStore.shared.currentUser {
            return members.filter({$0 != currentUser.id})
        }
        return []
        // guard let id = conversation.userIDs.filter({$0 != userID}).first else { return }
        // let isRead = conversation.isRead[userID] ?? true
    }
    
    // 생성일 (년 월 일 시 분 초)
    var createDateString: String {
        DateService.shared.createDateFormat(createdDate)
    }
    
    // 년 월 일
    var lastMessageDateString: String {
        DateService.shared.lastMessageDateFormat(lastMessageDate)
    }
    
    // 시:분
    var lastMessageTimeString: String {
        DateService.shared.lastMessageFormat(lastMessageDate)
    }
}
