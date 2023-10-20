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
import FirebaseStorage

final class MessageStore: ObservableObject {
    // 메시지
    @Published var messages: [ChatMessage] = []
    @Published var isMessageAdded: Bool = false
    @Published var isFetchMessageDone: Bool = false
    // 리스너
    private var listener: ListenerRegistration?
    private let db = Firestore.firestore()
    // 입장한 채팅방
    var currentChat: ChatRoom?
    
}

// CRUD 익스텐션
extension MessageStore {
    func getChatMessageDocuments(_ chatRoomID: String) async -> QuerySnapshot? {
        do {
            let snapshot = try await db.collection("chatrooms")
                .document(chatRoomID)
                .collection("chatmessages")
                .order(by: "createdDate")
                .getDocuments()
            return snapshot
        } catch {
            print("Error - \(#file)- \(#function) : \(error.localizedDescription)")
        }
        return nil
    }
    
    // MARK: Method : 채팅 ID를 받아서 메세지들을 불러오는 함수
    func fetchMessages(chatID: String, unreadMessageCount: Int) async {
        
        let snapshot = await getChatMessageDocuments(chatID)
        var newMessages: [ChatMessage] = []
        
        if let snapshot {
            for document in snapshot.documents {
                do {
                    let message: ChatMessage = try document.data(as: ChatMessage.self)
                    newMessages.append(message)
                } catch {
                    print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
                }
            }
        }
        await writeMessages(messages: newMessages)
    }
    
    @MainActor
    private func writeMessages(messages: [ChatMessage]) {
        self.messages = messages
        isFetchMessageDone = true
    }
    
    // MARK: - Message Create
    func addMessage(_ message: ChatMessage, chatRoomID: String) {
        do {
            try db
                .collection("chatrooms")
                .document(chatRoomID)
                .collection("chatmessages")
                .document(message.id)
                .setData(from: message.self)
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
    }
    
    // 업데이트
    func updateMessage(_ message: ChatMessage, chatRoomID: String) async {
        let newMessage = message
        do {
            try await db
                .collection("chatrooms")
                .document(chatRoomID)
                .collection("chatmessages")
                .document(message.id)
                .updateData(
                    ["text" : message.text,
                     "createdDate" : message.createdDate])
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
    }
    
    func removeMessage(_ message: ChatMessage, chatRoomID: String) async {
        do {
            try await db
                .collection("chatrooms")
                .document(chatRoomID)
                .collection("chatmessages")
                .document(message.id)
                .delete()
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
    }
}

extension MessageStore {
    
    // 리스너에서 값이 더해졌을때 메시지 객체로 변환해서 추가하는 메서드
    func fetchNewMessage(change : QueryDocumentSnapshot) -> ChatMessage? {
        do {
            let newMessage = try change.data(as: ChatMessage.self)
            return newMessage
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
        return nil
    }
    
    // 리스너에서 삭제된 ID를 받아서 현재 Published 된 메시지 목록에서 삭제하는 메서드
    func removeDeletedMessage(change : QueryDocumentSnapshot) {
        guard let index = messages.firstIndex(where: { $0.id == change.documentID}) else {
            return
        }
        messages.remove(at: index)
    }
    
    func addListener(chatRoomID: String) {
        listener = db
            .collection("chatrooms")
            .document(chatRoomID)
            .collection("chatmessages")
            .addSnapshotListener({ snapshot, error in
                guard let snapshot else {
                    print("Error fetching documents: \(error!.localizedDescription)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    switch diff.type {
                    case .added:
                        if let newMessage = self.fetchNewMessage(change: diff.document) {
                            self.messages.append(newMessage)
                            // 메세지 추가 시 Chat Room View 스크롤을 최하단으로 내리기 위한 트리거
                            self.isMessageAdded.toggle()
                        }
                    case .modified:
                        let _ = 1
                    case .removed:
                        self.removeDeletedMessage(change: diff.document)
                    }
                }
            })
    }
    func removeListener() {
        guard let listener else {
            return
        }
        listener.remove()
    }
}
