//
//  ChatMessageListView.swift
//  Grew
//
//  Created by cha_nyeong on 10/13/23.
//

import SwiftUI

struct ChatMessageListView: View {
    @EnvironmentObject var chatStore: ChatStore
    @Binding var isMenuOpen: Bool
    @Binding var x: CGFloat
    
    var body: some View {
        VStack{
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        ForEach(chatStore.chatMessages) { chatMessage in
                            MessageBubbles(chatMessage: chatMessage, selectedBubble: chatMessage.bubbleOwner)
                        }
                    }
                }
            }
            
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .navigationBarItems(trailing: (
                Button(action: {
                    withAnimation {
                        isMenuOpen.toggle()
                        x = 0
                    }
                }) {
                    if !isMenuOpen {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large).foregroundColor(Color("chatGreen"))
                    }
                }
            ))
            .navigationTitle(isMenuOpen ? "" : "정금쪽")
            .navigationBarBackButtonHidden(isMenuOpen ? true : false)
            // 이거 쓰고 뷰 덮었을때 안밀려나는거 어케함 대체????????
            /*
             .safeAreaInset(edge: .bottom) {
             ChatBar
             .background(Color(.systemBackground).ignoresSafeArea())
             .shadow(radius: 0.5)
             }
             */
        }
    }
}

#Preview {
    ChatMessageListView(isMenuOpen: .constant(false), x: .constant(UIScreen.main.bounds.width))
}
