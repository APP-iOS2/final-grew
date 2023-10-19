//
//  ChatDetailView.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/24.
//

import FirebaseAuth
import FirebaseStorage
import SwiftUI

struct ChatDetailView: View {
    // 채팅방 데이터
    let chatRoom: ChatRoom
    @State private var isMenuOpen: Bool = false
    @State private var isExitButtonAlert = false
    @Environment(\.presentationMode) var presentationMode
    let width = UIScreen.main.bounds.width
    @State private var x = UIScreen.main.bounds.width
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
                                } else {
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
}
