//
//  MessageBubbles.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//

import Kingfisher
import SwiftUI

struct MessageBubbles: View {
    let chatMessage: ChatMessage
    let targetUserInfos: [User]
    var bubbleOwner: Bubble {
        if chatMessage.isSystem {
            return .system
        } else if chatMessage.uid == UserStore.shared.currentUser!.id! {
            return .my
        } else {
            return .other
        }
    }
    
    var body: some View {
        switch bubbleOwner {
        case .my:
            myBubble
        case .other:
            otherBubble
        case .system:
            systemBubble
        }
    }
    
    var usersImageUrl: String? {
        for targetUserInfo in targetUserInfos {
            if targetUserInfo.id == chatMessage.uid {
                return targetUserInfo.userImageURLString
            }
        }
        return nil
    }
    
    
    private var myBubble: some View {
        HStack(alignment: .bottom) {
            Spacer()
            VStack{
                Spacer()
                Text(chatMessage.createdDateString)
                    .font(.c2_R)
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(.gray)
            }
            VStack{
                if !chatMessage.attachImageURL.isEmpty {
                    KFImage.url(URL(string: chatMessage.attachImageURL))
                        .placeholder({ _ in
                            ProgressView("Loading...")
                        })
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                if chatMessage.text.isEmpty {
                    
                } else {
                    Text(chatMessage.text)
                        .font(.c1_R)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15) )
                }
            }
            .background(Color.Main)
            .cornerRadius(15)

        }
    }
    
    private var otherBubble: some View {
        HStack{
            VStack{
                CircularProfileImageView(chatMessage: nil, url: usersImageUrl, imagesize: .bubble)
                Spacer()
            }
            VStack(alignment: .leading){
                Text(chatMessage.userName)
                    .font(.c1_B)
                    .padding(EdgeInsets(top: 0, leading: 3, bottom: -4, trailing: 0))
                VStack{
                    // attachment photo URL
                    if !chatMessage.attachImageURL.isEmpty {
                        KFImage.url(URL(string: chatMessage.attachImageURL))
                            .placeholder({ _ in
                                ProgressView("Loading...")
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }

                    if chatMessage.text.isEmpty {
                        
                    } else {
                         Text(chatMessage.text)
                        .font(.c1_R)
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 11, leading: 15, bottom: 10, trailing: 15))
                    }
                }.cornerRadius(15)
                //                    .background(Color.LightGray2)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.LightGray2, lineWidth: 1)
                )
            }
            
            VStack{
                Spacer()
                Text(chatMessage.createdDateString)
                    .font(.c2_R)
                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(.gray)
            }
            Spacer()
        }.padding(.top, 10)
    }
    
    private var systemBubble: some View {
        VStack{
            Text(chatMessage.text)
                .font(.c1_R)
                .foregroundColor(.gray)
                .bold()
                .padding(10)
                .cornerRadius(25)
        }
    }
}
