//
//  ChatStore.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class ChatStore: ObservableObject {
    
    @Published var groups: [ChatRoom] = []
    @Published var chatMessages: [ChatMessage] = []
    
    var firestoreChatListener: ListenerRegistration?
    var firestoreGroupListener: ListenerRegistration?
    
    
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
    
    //닉네임 변경 + 업데이트
    /* func updateDisplayName(for user: User, displayName: String) async throws {
     let request = user.createProfileChangeRequest()
     request.displayName = displayName
     try await request.commitChanges()
     try await updateUserInfoForAllMessages(uid: user.uid, updatedInfo: ["displayName": user.displayName ?? "Guest"])
     } */
    
    ///제거하기
    func detachFirebaseChatListener() {
        self.firestoreChatListener?.remove()
    }
    
    ///리스너 제거하기
    func detachFirebaseGroupListener() {
        self.firestoreGroupListener?.remove()
    }
    
    ///Firebase프로필 사진 변경
    func updatePhotoURL(for user: FirebaseAuth.User, photoURL: URL) async throws {
        
        let request = user.createProfileChangeRequest()
        request.photoURL = photoURL
        try await request.commitChanges()
        
        // update UserInf for all messages
        try await updateUserInfoForAllMessages(uid: user.uid, updatedInfo: ["profilePhotoURL": photoURL.absoluteString])
    }
    
    ///채팅메시지용 리스너 설정
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
    /*
    ///현재 로그인 한 유저의 채팅방 패치 작업
    func listenForChatRoom() async throws {
        
        let db = Firestore.firestore()
        
        chatMessages.removeAll()
        
        guard let documentId =  else { return }
        
        self.firestoreChatListener = db.collection("users")
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
     */
    func populateGroups() async throws {
        
        let db = Firestore.firestore()
        let snapshot = try await db.collection("chatrooms")
            .getDocuments()
        
        groups = snapshot.documents.compactMap { try?
            $0.data(as: ChatRoom.self)
        }
//        .filter({ $0.id != currentUid})
    }
    
    //
    func saveChatMessageToGroup(chatMessage: ChatMessage, group: ChatRoom) async throws {
        
        let db = Firestore.firestore()
        guard let groupDocumentId = group.id else { return }
        let _ = try db.collection("chatrooms")
            .document(groupDocumentId)
            .collection("chatmessages")
            .document(chatMessage.id ?? "error")
            .setData(from: chatMessage)
//            .addDocument(data: chatMessage.toDictionary())
    }
    
    /*
     func saveChatMessageToGroup(text: String, group: Group, completion: @escaping (Error?) -> Void) {
     
     let db = Firestore.firestore()
     guard let groupDocumentId = group.documentId else { return }
     db.collection("groups")
     .document(groupDocumentId)
     .collection("messages")
     .addDocument(data: ["chatText": text]) { error in
     completion(error)
     }
     } */
    
    
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
