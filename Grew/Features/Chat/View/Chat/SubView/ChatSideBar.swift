//
//  ChatSideBar.swift
//  Grew
//
//  Created by daye on 10/11/23.
//

import SwiftUI

struct ChatSideBar: View {
    @Binding var isMenuOpen: Bool
    @Binding var isExitButtonAlert: Bool
    let chatRoomName: String
    let targetUserInfos: [User]
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var show = true
    
    var body: some View {
        HStack(spacing: 0){
            Spacer(minLength: 0)
            Divider()
            VStack(alignment: .leading){
                Text(chatRoomName)
                    .font(.b1_B)
                    .padding(.top, 30)
                Divider()
                ScrollView{
                    Group{
                        HStack{
                            Text("함께하는 멤버")
                            Text("\(targetUserInfos.count+1)").foregroundColor(.gray)
                            Spacer()
                        }.font(.b2_R)
                            .padding(.vertical, 15)
                        // 나
                        HStack{
                            CircularProfileImageView(
                                chatMessage: nil,
                                url: UserStore.shared.currentUser?.userImageURLString ?? "",
                                imagesize: .bubble)
                            Text("\(UserStore.shared.currentUser?.nickName ?? "login error")").font(.b3_B).padding(3)
                            Spacer()
                        }
                        // 딴사람
                        ForEach(targetUserInfos) { i in
                            HStack {
                                CircularProfileImageView(
                                    chatMessage: nil,
                                    url: i.userImageURLString,
                                    imagesize: .bubble)
                                Text(i.nickName).font(.b3_R).padding(3)
                                Spacer()
                            }
                            .padding(.top, 10)
                        }
                    }.frame(width: UIScreen.main.bounds.width - 120, alignment: .leading)
                }.frame(height: (UIScreen.main.bounds.height * 0.7))
                
                Divider()
                sideBottomItems
                    .padding(.bottom, 20)
                Spacer()
                
            }
            .padding(.horizontal, 20)
            .padding(.top, edges!.top == 0 ? 15 : edges?.top)
            .padding(.bottom, edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: UIScreen.main.bounds.width - 90 )
            .background(Color.white)
            
        }
    }
    
    private var sideBottomItems: some View {
        HStack{
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .onTapGesture {
                    isExitButtonAlert.toggle()
                }
        }.padding()
    }
}

#Preview {
    ChatSideBar(isMenuOpen: .constant(true), isExitButtonAlert: .constant(true), chatRoomName: "감자탕 모임", targetUserInfos: [User]())
}
