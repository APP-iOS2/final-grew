//
//  ChatStore.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

@MainActor
class ChatStore: ObservableObject {
    
    @Published var chatMessages: [ChatMessage] = []
    
    var firestoreChatListener: ListenerRegistration?
    
    private func updateUserInfoForAllMessages(uid: String, updatedInfo: [AnyHashable: Any]) async throws {
        
        let db = Firestore.firestore()
        
        let groupDocuments = try await db.collection("chatrooms").getDocuments().documents
        
        for groupDoc in groupDocuments {
            let messages = try await groupDoc.reference.collection("chatmessages")
                .whereField("uid", isEqualTo: uid)
                .getDocuments().documents
            
            for message in messages {
                try await message.reference.updateData(updatedInfo)
            }
        }
    }
    
    /// 제거하기
    func detachFirebaseChatListener() {
        self.firestoreChatListener?.remove()
    }
    
    /// Firebase프로필 사진 변경
    func updatePhotoURL(for user: FirebaseAuth.User, photoURL: URL) async throws {
        
        let request = user.createProfileChangeRequest()
        request.photoURL = photoURL
        try await request.commitChanges()
        
        // update UserInf for all messages
        try await updateUserInfoForAllMessages(uid: user.uid, updatedInfo: ["profilePhotoURL": photoURL.absoluteString])
    }
    
    /// 채팅메시지용 리스너 설정
    func listenForChatMessages(in chatroom: ChatRoom) {
        
        let db = Firestore.firestore()
        
        chatMessages.removeAll()
        
        guard let documentId = chatroom.id else { return }
        
        self.firestoreChatListener = db.collection("chatrooms")
            .document(documentId)
            .collection("chatmessages")
            .order(by: "createdDate", descending: false)
            .addSnapshotListener({ [weak self] snapshot, error in
                
                guard let snapshot = snapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                
                snapshot.documentChanges.forEach { diff in
                    if diff.type == .added {
                        do {
                            let snapshot = diff.document
                            let diffdata = try snapshot.data(as: ChatMessage.self)
                            
                            let exists = self?.chatMessages.contains(where: { cm in
                                cm.id == diffdata.id
                            })
                            if !exists! {
                                self?.chatMessages.append(diffdata)
                            }
                        } catch {
                            print("error Decoding Data")
                        }
                    }
                }
            })
    }
    
    func saveChatMessageToGroup(chatMessage: ChatMessage, group: ChatRoom) async throws {
        let db = Firestore.firestore()
        guard let groupDocumentId = group.id else { return }
        try db.collection("chatrooms")
            .document(groupDocumentId)
            .collection("chatmessages")
            .document(chatMessage.id ?? "error")
            .setData(from: chatMessage)
        //            .addDocument(data: chatMessage.toDictionary())
    }
    
    
    func saveGroup(group: ChatRoom) {
        do {
            let db = Firestore.firestore()
            try db.collection("groups")
                .document(group.id ?? "errorSaveGroup")
                .setData(from: group)
        } catch {
            print("Failed to SaveGroup")
        }
    }
}
