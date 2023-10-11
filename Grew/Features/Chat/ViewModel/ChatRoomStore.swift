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
class ChatRoomStore: ObservableObject {
    
    @Published var chatRooms: [ChatRoom] = []
    
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
    
    // 닉네임 변경 + 업데이트
    /* func updateDisplayName(for user: User, displayName: String) async throws {
     let request = user.createProfileChangeRequest()
     request.displayName = displayName
     try await request.commitChanges()
     try await updateUserInfoForAllMessages(uid: user.uid, updatedInfo: ["displayName": user.displayName ?? "Guest"])
     } */
    
    /// 리스너 제거하기
    func detachFirebaseGroupListener() {
        self.firestoreGroupListener?.remove()
    }
    
    /// Firebase프로필 사진 변경
    func updatePhotoURL(for user: FirebaseAuth.User, photoURL: URL) async throws {
        
        let request = user.createProfileChangeRequest()
        request.photoURL = photoURL
        try await request.commitChanges()
        
        // update UserInf for all messages
        try await updateUserInfoForAllMessages(uid: user.uid, updatedInfo: ["profilePhotoURL": photoURL.absoluteString])
    }
    
    ///현재 로그인 한 유저의 채팅방 패치 작업
    func listenForChatRoom() async throws {
        
        let db = Firestore.firestore()
        
        chatRooms.removeAll()
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        //        guard let documentId =  else { return }
        
        self.firestoreGroupListener = db.collection("ChatRooms")
            .whereField("members", arrayContains: currentUid)
            .order(by: "timestamp", descending: false)
            .addSnapshotListener({ [weak self] snapshot, error in
                
                guard let snapshot = snapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                
                snapshot.documentChanges.forEach { diff in
                    if diff.type == .added {
                        do {
                            let snapshot = diff.document
                            let diffdata = try snapshot.data(as: ChatRoom.self)
                            
                            let exists = self?.chatRooms.contains(where: { cm in
                                cm.id == diffdata.id
                            })
                            if !exists! {
                                self?.chatRooms.append(diffdata)
                            }
                        } catch {
                            print("error Decoding Data")
                        }
                    } else if diff.type == .removed {
                        do {
                            let snapshot = diff.document
                            let diffdata = try snapshot.data(as: ChatRoom.self)
                            
                            let exists = self?.chatRooms.contains(where: { cr in
                                cr.id == diffdata.id
                            })
                            if !exists! {
                                self?.chatRooms.removeAll(where: { cr in cr.id == diffdata.id
                                })
                            }
                        } catch {
                            print("error Decoding Data")
                        }
                        
                    }
                }
            })
    }
    
    func populateGroups() async throws {
        
        let db = Firestore.firestore()
        let snapshot = try await db.collection("chatrooms")
            .getDocuments()
        
        chatRooms = snapshot.documents.compactMap { try?
            $0.data(as: ChatRoom.self)
        }
        //        .filter({ $0.id != currentUid})
    }
}
