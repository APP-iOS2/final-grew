//
//  ChatStore.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


final class ChatStore: ObservableObject {
    
    private var listener: ListenerRegistration?
    private var db = Firestore.firestore()
    
    // 해당 유저, 그루 값 들고 있기
    var targetUserInfoDict: [String: [User]]
    var targetGrewInfoDict: [String: Grew]
    
    @Published var newChat: ChatRoom?
    @Published var chatRooms: [ChatRoom]
    /// 스켈레톤 UI 즉 로딩 시간 사이에 패치를 나타내는 뷰를 잠시동안 보여줄 수 있는 Bool 값
    @Published var isDoneFetch: Bool
    
    init() {
        targetUserInfoDict = [:]
        targetGrewInfoDict = [:]
        chatRooms = []
        isDoneFetch = false
    }
    
    var groupChatRooms: [ChatRoom] {
        chatRooms.filter({ $0.chatRoomName != nil })
    }
    
    var personalChatRooms: [ChatRoom] {
        chatRooms.filter({ $0.chatRoomName == nil })
    }
}

// CRUD 작업
extension ChatStore {
    // 채팅방 목록 가져오기
    func getChatRoomDocuments() async -> QuerySnapshot? {
        do {
            print(UserStore.shared.currentUser)
            guard let currentUser = UserStore.shared.currentUser else {
                return nil
            }
            let snapshot = try await db
                .collection("chatrooms")
                .whereField("members", arrayContains: currentUser.id ?? "")
                .order(by: "lastMessageDate", descending: true)
                .getDocuments()
            return snapshot
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
        return nil
    }
    
    
    // fetching만 빼기
    @MainActor
    func allocateChatRooms(chatRooms: [ChatRoom]) {
        self.chatRooms = chatRooms
        self.isDoneFetch = true
    }
    
    // 채팅룸 목록 삭제하기
    @MainActor
    func removeChatRoomsList() {
        chatRooms.removeAll()
    }
    
    // 채팅방 fetch하면서 연관된 User정보 값 가지고 있기
    func fetchChatRooms() async {
        let snapshot = await getChatRoomDocuments()
        
        var newChatRooms: [ChatRoom] = []
        
        if let snapshot {
            for document in snapshot.documents {
                do {
                    let chatRoom: ChatRoom = try document.data(as: ChatRoom.self)
                    if let grewId = chatRoom.grewId, let targetGrewInfo = await GrewViewModel.requestAndReturnGrew(grewId: grewId) {
                        targetGrewInfoDict[grewId] = targetGrewInfo
                    }
                    if let targetUserInfo = await UserStore.requestAndReturnUsers(userID: chatRoom.otherUserIDs) {
                        newChatRooms.append(chatRoom)
                        if !targetUserInfo.isEmpty {
                            targetUserInfoDict[chatRoom.id] = targetUserInfo
                        }
                    }
                } catch {
                    print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
                }
            }
        }
        
        await allocateChatRooms(chatRooms: newChatRooms)
    }
    
    func addChatRoom(_ chatRoom: ChatRoom) async {
        do {
            try db.collection("chatrooms")
                .document(chatRoom.id)
                .setData(from: chatRoom.self)
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
    }
    
    func updateChatRoom(_ chatRoom: ChatRoom) async {
        do {
            try await db.collection("chatrooms")
                .document(chatRoom.id)
                .updateData([
                    "lastMessageDate": chatRoom.lastMessageDate,
                    "lastMessage": chatRoom.lastMessage,
                    "unreadMessageCount" : chatRoom.unreadMessageCount
                ])
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
    }
    
    func removeChatRoom(_ chatRoom: ChatRoom) async {
        do {
            try await db.collection("chatrooms")
                .document(chatRoom.id)
                .delete()
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
    }
    
    func getUnreadMessageDictionary(chatRoomID: String) async -> [String: Int]? {
        do {
            let snapshot = try await db.collection("chatrooms")
                .document(chatRoomID)
                .getDocument()
            
            if let data = snapshot.data() {
                let dict = data["unreadMessageCount"] as? [String: Int] ?? ["no one": 0]
                return dict
            }
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
        return nil
    }
}

// 리스너 관리

extension ChatStore {
    // 최신 메시지 온 순으로 정렬
    func sortChatRooms() {
        chatRooms.sort {
            $0.lastMessageDate > $1.lastMessageDate
        }
    }
    
    // 리스너에서 스냅샷 데이터로 채팅방 인스턴스를 만드는 메서드
    func newChatRoom(change: QueryDocumentSnapshot) -> ChatRoom? {
        do {
            let newChatRoom = try change.data(as: ChatRoom.self)
            return newChatRoom
        } catch {
            print("Error-\(#file)-\(#function) : \(error.localizedDescription)")
        }
        return nil
    }
    
    // 리스너에서 type = .added 처리
    func listenerAddChatRoom(change: QueryDocumentSnapshot) async {
        let newChatRoom = newChatRoom(change: change)
        
        if let newChatRoom, let targetUserInfo = await UserStore.requestAndReturnUsers(userID: newChatRoom.otherUserIDs) {
            if !targetUserInfo.isEmpty {
                targetUserInfoDict[newChatRoom.id] = targetUserInfo
            }
            await appendAndSortChats(newChatRoom: newChatRoom)
        }
    }
    
    // 채팅방 정렬
    @MainActor
    func appendAndSortChats(newChatRoom: ChatRoom) {
        chatRooms.append(newChatRoom)
        sortChatRooms()
    }
    
    // 리스너에서 update 처리 ex)채팅방 내부에서 채팅이 입력되어서 채팅방에 마지막 메시지 갱신, 마지막 날짜 갱신, 유저별 안읽은 채팅 개수 갱신
    @MainActor 
    func listenerUpdateChatRooms(change: QueryDocumentSnapshot) {
        updateChatRooms(change: change)
        sortChatRooms()
    }
    
    // 업데이트
    @MainActor
    func updateChatRooms(change: QueryDocumentSnapshot) {
        guard let index = chatRooms.firstIndex(where: {
            $0.id == change.documentID}) else {
            return
        }
        let newChatRoom = newChatRoom(change: change)
        if let newChatRoom {
            chatRooms[safe: index] = newChatRoom
        }
    }
    
    @MainActor
    func removeAndSortChats(newChatRoom: ChatRoom) {
        chatRooms.removeAll(where: {$0.id == newChatRoom.id })
        sortChatRooms()
    }
    
    func listenerRemoveChatRoom(change: QueryDocumentSnapshot) async {
        let newChatRoom = newChatRoom(change: change)
        
        if let newChatRoom {
            targetUserInfoDict[newChatRoom.id] = nil
            await removeAndSortChats(newChatRoom: newChatRoom)
        }
    }
    
    func addListener() {
        guard let currentUid = UserStore.shared.currentUser?.id else {
            return
        }
        
        listener = db
            .collection("chatrooms")
            .whereField("members", arrayContains: currentUid)
            .addSnapshotListener({ snapshot, error in
                guard let snapshot else { return }
                
                snapshot.documentChanges.forEach { diff in
                    switch diff.type {
                    case .added:
                        if self.isDoneFetch {
                            Task {
                                await self.listenerAddChatRoom(change: diff.document)
                            }
                        }
                    case .modified:
                        Task {
                            await self.listenerUpdateChatRooms(change: diff.document)
                        }
                    case .removed:
                        Task {
                            await self.listenerRemoveChatRoom(change: diff.document)
                        }
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
