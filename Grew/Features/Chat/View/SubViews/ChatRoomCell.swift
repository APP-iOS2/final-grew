//
//  ChatRoomCell.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//

import SwiftUI

struct ChatRoomCell: View {
    
    let chatMessage: ChatMessage
    
    var body: some View {
        HStack{
            CircularProfileImageView(chatMessage: chatMessage, url: nil, imagesize: .chatRoomList)
            
            VStack(alignment: .leading){
                Text("정금쪽").bold().padding(0.005)
                Text("넹넹넹넹넹넹넹").foregroundColor(.gray).font(.callout)
            }

            Spacer()
            
            VStack(alignment: .trailing){
                Text("오후 8:08")
                    .foregroundColor(.gray)
                    .font(.callout)
                ZStack{
                    Text("3")
                        .foregroundColor(.white)
                        .font(.caption)
                        .bold()
                        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .background(.red)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct ChatRoomCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomCell(chatMessage: ChatMessage.dummyChat1)
    }
}
