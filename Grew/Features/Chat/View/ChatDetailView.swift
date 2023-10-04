//
//  ChatDetailView.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/24.
//

import SwiftUI

struct ChatDetailView: View {
    @State var text: String = ""
    @State var isMenuOpen: Bool = false
    @State var showMenu = false
    
    var body: some View {
        ZStack{
            //채팅
            MessageView
                .zIndex(1)
                .onTapGesture {
                    if(isMenuOpen){
                        withAnimation(.easeInOut){
                            isMenuOpen.toggle()
                        }
                    }
                }
            
            //사이드 메뉴 바
            if(isMenuOpen){
                HStack(){
                    Spacer()
                    ChatSideMenuView(isMenuOpen: $isMenuOpen)
                }.transition(.move(edge: .trailing))
                    .gesture(DragGesture().onEnded({ value in
                        if value.translation.width > 0 {
                            withAnimation(.easeInOut){
                                isMenuOpen.toggle()
                            }
                        }
                    })
                    )
                    .zIndex(2)
            }
        }
    }
    
    private var MessageView: some View {
        ScrollView(){
            MessageBubbles(chatMessage: ChatMessage.dummyChat, selectedBubble: .admin)
            MessageBubbles(chatMessage: ChatMessage.dummyChat1, selectedBubble: .my)
            MessageBubbles(chatMessage: ChatMessage.dummyChat2, selectedBubble: .other)
            MessageBubbles(chatMessage: ChatMessage.dummyChat3, selectedBubble: .admin)
            MessageBubbles(chatMessage: ChatMessage.dummyChat4, selectedBubble: .my)
            MessageBubbles(chatMessage: ChatMessage.dummyChat1, selectedBubble: .other)
            MessageBubbles(chatMessage: ChatMessage.dummyChat2, selectedBubble: .other)
            
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .safeAreaInset(edge: .bottom) {
                ChatBar
                    .background(Color(.systemBackground).ignoresSafeArea())
                    .shadow(radius: 0.5)
            }.navigationBarItems(trailing: (
                Button(action: {
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }) {
                    if(!isMenuOpen){
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large).foregroundColor(Color("ChatGreen"))
                    }
                }
            )).navigationTitle(isMenuOpen ? "" : "정금쪽")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var ChatBar: some View {
        HStack{
            TextField("메세지 보내기", text: $text)
            Button {
                text=""
            } label: {
                Image(systemName: "arrow.up.circle.fill").font(.title).foregroundColor(text=="" ? .gray : Color("ChatGreen"))
            }
        }.padding()
           
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ChatDetailView()
        }
    }
}
