//
//  MessageStore.swift
//  Grew
//
//  Created by cha_nyeong on 10/17/23.
//

// TODO: - 해야 할 것

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class MessageStore: ObservableObject {
    // 메시지
    @Published var messages: [ChatMessage] = []
    @Published var isMessageAdded: Bool = false
    // 리스너
    private var listener: ListenerRegistration?
    private let db = Firestore.firestore()
    // 입장한 채팅방
    var currentChat: ChatRoom?
    
}

// Crud 익스텐션
extension MessageStore {
    func getChatMessage(_ chatRoomID: String) { }
}
