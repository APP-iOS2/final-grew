//
//  MessageBubbles.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//

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
    
    private var myBubble: some View {
        HStack {
            Spacer()
            Text("8시 8분")
                .font(.caption2)
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                .foregroundColor(.gray)
            Text(chatMessage.text)
                .font(.callout)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15) )
                .background(Color.Main)
                .cornerRadius(25)
        }
    }
    
    private var otherBubble: some View {
        HStack{
            CircularProfileImageView(chatMessage: chatMessage, url: nil, imagesize: .bubble)
            VStack(alignment: .leading){
                Text("정금쪽")
                    .font(.caption)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 3, bottom: -4, trailing: 0))
                Text(chatMessage.text)
                    .font(.callout)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("chatGray"), lineWidth: 1)
                    )
                    .background(Color("CustomGray"))
            }
            
            Text("8시 7분").font(.caption).padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0)).foregroundColor(.gray)
            Spacer()
        }
    }
    
    private var systemBubble: some View {
        VStack{
            Text(chatMessage.text)
                .font(.caption)
                .foregroundColor(.gray)
                .bold()
                .padding(10)
                .cornerRadius(25)
        }
    }
}

