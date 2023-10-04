//
//  MessageBubbles.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//

import SwiftUI

struct MessageBubbles: View {
    
    let chatMessage: ChatMessage
    let selectedBubble: Bubble
    
    var body: some View {
        switch selectedBubble {
        case .my:
            MyBubble
        case .other:
            OtherBubble
        case .admin:
            AdminBubble
        }
    }
    
    private var MyBubble: some View {
        HStack{
            Spacer()
            Text("8시 8분")
                .font(.caption2)
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                .foregroundColor(.gray)
            Text(chatMessage.text)
                .font(.callout)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15) )
                .background(Color("ChatGreen"))
                .cornerRadius(25)
        }
    }
    
    private var OtherBubble: some View {
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
                            .stroke(Color("CustomGray"), lineWidth: 1)
                    )
                //.background(Color("CustomGray"))
            }
            
            Text("8시 7분").font(.caption).padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0)).foregroundColor(.gray)
            Spacer()
        }
    }
    
    private var AdminBubble: some View {
        VStack(){
            Text(chatMessage.text)
                .font(.caption)
                .foregroundColor(.gray)
                .bold()
                .padding(10)
                //.background(Color("CustomGray"))
                .cornerRadius(25)
        }
    }
}

struct MessageBubbles_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubbles(chatMessage: ChatMessage.dummyChat, selectedBubble: .other)
    }
}
