//
//  ChatListView.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/25.
//

import SwiftUI


struct ChatListView: View {
    
    var body: some View {
        mainContentView
    }
    
    private var mainContentView: some View{
        ScrollView{
            ForEach(0..<8){ i in
                NavigationLink {
                    ChatDetailView()
                } label: {
                    ChatRoomCell(chatMessage: ChatMessage.dummyChat1)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                    .listSectionSeparator(.hidden)
            }
            .foregroundColor(.black)
        }
    }
    
}



struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ChatListView()
        }
    }
}
