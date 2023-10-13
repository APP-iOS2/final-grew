//
//  ChatDetailView.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct ChatDetailView: View {
    // 채팅방 데이터
    let chatRoom: ChatRoom
    @State var isMenuOpen: Bool = false
    @State var isExitButtonAlert = false
    @Environment(\.presentationMode) var presentationMode
    var width = UIScreen.main.bounds.width
    @State var x = UIScreen.main.bounds.width
    @State private var groupDetailConfig = GroupDetailConfig()
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var chatStore: ChatStore
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 채팅
                ChatMessageListView(isMenuOpen: $isMenuOpen, x: $x)
                    .zIndex(1)
                
                // 채팅 입력창
                VStack {
                    Spacer()
                    if groupDetailConfig.selectedImage != nil {
                        HStack {
                            Spacer()
                        }
                    }
                    ChatInputView(chatRoom: chatRoom, groupDetailConfig: $groupDetailConfig)
                        .background(Color(.systemBackground).ignoresSafeArea())
                        .shadow(radius: 0.5)
                        .position(x: geometry.size.width / 2, y: geometry.size.height-30)
                }
                .zIndex(2)
                
                // 사이드 메뉴 바
                if isMenuOpen {
                    SideBarShadowView(isMenuOpen: $isMenuOpen)
                        .zIndex(3)
                    ChatSideBar(isMenuOpen: $isMenuOpen, isExitButtonAlert: $isExitButtonAlert)
                        .offset(x: x)
                        .transition(isMenuOpen == true ? .move(edge: .trailing) : .identity)
                        .gesture(DragGesture().onChanged({ (value) in
                            withAnimation(.easeInOut){
                                if value.translation.width < 0 {
                                    x = width + value.translation.width
                                }else{
                                    x = value.translation.width
                                }
                            }
                        }).onEnded({ (value) in
                            withAnimation(.easeInOut) {
                                if x < width / 2 {
                                    x = 0
                                } else {
                                    x = width
                                    isMenuOpen = false
                                }
                            }
                        }))
                        .zIndex(4)
                }
            }
            .alert("채팅방 나가기", isPresented: $isExitButtonAlert) {
                Button("취소", role: .cancel) {}
                Button("확인", role: .destructive) {
                    isMenuOpen = false
                    presentationMode.wrappedValue.dismiss()
                }
            } message: {
                Text("채팅 내역이 모두 삭제됩니다.")
            }
            .confirmationDialog("Options", isPresented: $groupDetailConfig.showOptions, actions: {
                Button("Camera") {
                    groupDetailConfig.sourceType = .camera
                }
                Button("Photo Library") {
                    groupDetailConfig.sourceType = .photoLibrary
                }
            })
            .sheet(item: $groupDetailConfig.sourceType, content: { sourceType in
                ChatImagePicker(image: $groupDetailConfig.selectedImage, sourceType: sourceType)
            })
        }
    }
    
    private func sendMessage() async throws {
        guard let currentUser = UserStore.shared.currentUser else { return }
        
        var chatMessage = ChatMessage(
            text: groupDetailConfig.chatText,
            uid: currentUser.id,
            groupId: chatRoom.id,
            userName: currentUser.nickName,
            profileImageURL: currentUser.userImageURLString ?? "",
            isAdmin: false
        )
        
        if let selectedImage = groupDetailConfig.selectedImage {
            // resize the image
            guard let resizedImage = selectedImage.resize(to: CGSize(width: 600, height: 600)),
                  let imageData = resizedImage.pngData()
            else { return }
        
            let url = try await Storage.storage().uploadData(for: UUID().uuidString, data: imageData, bucket: .attachments)
            chatMessage.attachImageURL = url.absoluteString
        }
        
        try await chatStore.saveChatMessageToGroup(chatMessage: chatMessage, group: chatRoom)
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ChatDetailView(chatRoom: ChatRoom(id: "asdf", chatRoomName: "채팅방 더미", members: ["asdf", "bads", "manager"], lastMessage: "마지막 메시지가 이건데", timestamp: Date()))
        }
    }
}
