//
//  ChatInputView.swift
//  Grew
//
//  Created by cha_nyeong on 10/13/23.
//

import SwiftUI

struct ChatInputView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var chatStore: ChatStore
    @EnvironmentObject var messageStore: MessageStore
    let chatRoom: ChatRoom
    @Binding var groupDetailConfig: GroupDetailConfig
    @FocusState var isChatTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            Button {
                groupDetailConfig.showOptions = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(Color.Main)
            }
            TextMaster(text: $groupDetailConfig.chatText, isFocused: $isChatTextFieldFocused, maxLine: 5, fontSize: 15)
                .padding(.horizontal, 10)
                .overlay(
                    Capsule()
                        .stroke(isChatTextFieldFocused ? Color.grewMainColor : Color.gray, lineWidth: 1)
                )
                .font(.c1_R)
            //            TextField("메세지 보내기", text: $groupDetailConfig.chatText)
            //                .focused($isChatTextFieldFocused)
            Button {
                Task {
                    if groupDetailConfig.selectedImage != nil, !groupDetailConfig.chatText.isEmptyOrWhiteSpace {
                        await sendMessageAndPhoto()
                    } else {
                        await sendMessage()
                    }
                }
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.title2)
                    .foregroundColor(!groupDetailConfig.isValid ? .gray : Color.Main)
            }
            .disabled(!groupDetailConfig.isValid)
        }
    }
    
    private func clearFields() {
        groupDetailConfig.clearForm()
        //        appState.loadingState = .idle
    }
    
    private func sendMessage() async {
        var newMessage = makeMessage(config: groupDetailConfig)
        let newChat = await makeChatRoomForSend()
        
        if let image = groupDetailConfig.selectedImage {
            do {
                let imageUrl =  try await ImageUploader.uploadImage(path: "attachment/\(UUID().uuidString)", image: image)
                newMessage.attachImageURL = imageUrl ?? ""
            } catch {
                print(error.localizedDescription)
            }
        }
        messageStore.addMessage(newMessage, chatRoomID: chatRoom.id)
        await chatStore.updateChatRoom(newChat)
        
        clearFields()
    }
    
    private func sendMessageAndPhoto() async {
        var newPhotoMessage = makeMessage(config: groupDetailConfig)
        let newMessage = makeMessage(config: groupDetailConfig)
        let newChat = await makeChatRoomForSend()
        
        if let image = groupDetailConfig.selectedImage {
            do {
                let imageUrl =  try await ImageUploader.uploadImage(path: "attachment/\(UUID().uuidString)", image: image)
                newPhotoMessage.attachImageURL = imageUrl ?? ""
                newPhotoMessage.text = ""
            } catch {
                print(error.localizedDescription)
            }
        }
        messageStore.addMessage(newPhotoMessage, chatRoomID: chatRoom.id)
        messageStore.addMessage(newMessage, chatRoomID: chatRoom.id)
        await chatStore.updateChatRoom(newChat)
        
        clearFields()
    }
    
    private func makeMessage(config: GroupDetailConfig) -> ChatMessage {
        let newMessage = ChatMessage.init(
            text: config.chatText,
            uid: UserStore.shared.currentUser!.id!,
            userName: UserStore.shared.currentUser!.nickName
        )
        return newMessage
    }
    
    //
    private func makeChatRoomForSend() async -> ChatRoom {
        var newChatRoom: ChatRoom = chatRoom
        var newUnreadMessageCountDict: [String: Int] = await chatStore.getUnreadMessageDictionary(chatRoomID: chatRoom.id) ?? [:]
        
        for userID in chatRoom.otherUserIDs {
            newUnreadMessageCountDict[userID, default: 0] += 1
        }
        newChatRoom.lastMessage = groupDetailConfig.chatText.isEmpty ? "사진을 보냈습니다." : groupDetailConfig.chatText
        newChatRoom.lastMessageDate = .now
        newChatRoom.unreadMessageCount = newUnreadMessageCountDict
        
        return newChatRoom
    }
}
