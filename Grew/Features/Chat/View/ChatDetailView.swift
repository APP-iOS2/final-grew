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
    @State var isExitButtonAlert = false
    @Environment(\.presentationMode) var presentationMode
    private var width = UIScreen.main.bounds.width
    @State var x = UIScreen.main.bounds.width
    
    var body: some View {
        GeometryReader { geometry in
        
            ZStack{
                // 채팅
                messageView
                    .zIndex(1)
                
                // 채팅 입력창
                VStack{
                    Spacer()
                    chatBar
                        .background(Color(.systemBackground).ignoresSafeArea())
                        .shadow(radius: 0.5)
                        .position(x: geometry.size.width / 2, y: geometry.size.height-30)
                        
                }.zIndex(2)
                
                // 사이드 메뉴 바
                if(isMenuOpen){
                    shadowView
                        .zIndex(3)
                    ChatSideBar(isMenuOpen: $isMenuOpen, isExitButtonAlert: $isExitButtonAlert)
                        .offset(x:x)
                        .transition(isMenuOpen==true ? .move(edge: .trailing) : .identity)
                        .gesture(DragGesture().onChanged({ (value) in
                            withAnimation(.easeInOut){
                                if value.translation.width < 0 {
                                    x = +width + value.translation.width
                                }else{
                                    x = value.translation.width
                                }
                            }
                        }).onEnded({ (value) in
                            withAnimation(.easeInOut){
                                if x < width / 2{
                                    x = 0
                                }else {
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
        }
    }
    
    private var messageView: some View {
        
        ScrollView{
            MessageBubbles(chatMessage: ChatMessage.dummyChat, selectedBubble: .admin)
            MessageBubbles(chatMessage: ChatMessage.dummyChat1, selectedBubble: .my)
            MessageBubbles(chatMessage: ChatMessage.dummyChat2, selectedBubble: .other)
            MessageBubbles(chatMessage: ChatMessage.dummyChat3, selectedBubble: .admin)
            MessageBubbles(chatMessage: ChatMessage.dummyChat4, selectedBubble: .my)
            MessageBubbles(chatMessage: ChatMessage.dummyChat1, selectedBubble: .other)
            MessageBubbles(chatMessage: ChatMessage.dummyChat2, selectedBubble: .other)
            
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .navigationBarItems(trailing: (
            Button(action: {
                withAnimation {
                    isMenuOpen.toggle()
                    x = 0
                }
            }) {
                if(!isMenuOpen){
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large).foregroundColor(Color("chatGreen"))
                }
            }
        )).navigationTitle(isMenuOpen ? "" : "정금쪽")
            .navigationBarBackButtonHidden(isMenuOpen ? true : false)
            .navigationBarTitleDisplayMode(.inline)
        // 이거 쓰고 뷰 덮었을때 안밀려나는거 어케함 대체????????
        /*.safeAreaInset(edge: .bottom) {
         ChatBar
         .background(Color(.systemBackground).ignoresSafeArea())
         .shadow(radius: 0.5)
         }*/
    }
    
    
    private var chatBar: some View {
        HStack{
            Button {
            } label: {
                Image(systemName: "plus")
            }
            TextField("메세지 보내기", text: $text)
            Button {
                text = ""
            } label: {
                Image(systemName: "arrow.up.circle.fill").font(.title).foregroundColor(text.isEmpty ? .gray : Color.Main)
            }
        }.padding()
        
    }
    
    
    private var shadowView: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height+100) //SlideMenuView에서 ScrollView 크기 조정해줬더니 밀려나서 +100 해줌
            .foregroundColor(Color.black.opacity(0.5))
            .ignoresSafeArea(.all, edges: .all)
            .onTapGesture {
                withAnimation(.easeInOut){
                    isMenuOpen = false
                }
            }
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ChatDetailView()
        }
    }
}
