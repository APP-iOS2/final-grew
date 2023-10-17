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
        HStack{
            Button {
                groupDetailConfig.showOptions = true
            } label: {
                Image(systemName: "plus")
            }
            TextField("메세지 보내기", text: $groupDetailConfig.chatText)
                .focused($isChatTextFieldFocused)
            Button {
                Task {
                    do {
                        clearFields()
                    } catch {
                        print(error.localizedDescription)
                        clearFields()
                    }
                }
            } label: {
                Image(systemName: "arrow.up.circle.fill").font(.title).foregroundColor(!groupDetailConfig.isValid ? .gray : Color.Main)
            }
        }.padding()
    }
    
    private func clearFields() {
        groupDetailConfig.clearForm()
        appState.loadingState = .idle
    }
}

