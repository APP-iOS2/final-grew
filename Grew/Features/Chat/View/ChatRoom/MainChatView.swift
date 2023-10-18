//
//  UserContentListView.swift
//  ChatTestProject
//
//  Created by dayexx on 2023/09/25.
//

import SwiftUI

struct MainChatView: View {
    var user: User?
    
    @State private var selectedFilter: ChatSegment = .group
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ChatSegment.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    
    var body: some View {
        // user content list view
        VStack{
            HStack{
                ForEach(ChatSegment.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(Color("chatGreen"))
                                .frame(maxWidth: filterBarWidth, maxHeight: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(maxWidth: filterBarWidth, maxHeight: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            
            switch selectedFilter {
            case .group:
                ChatListView(filter: .group)
            case .personal:
                ChatListView(filter: .personal)
            }
            Spacer()
        }
        .highPriorityGesture(
            DragGesture(minimumDistance: 2, coordinateSpace: .local)
                .onEnded { value in
                    if (selectedFilter == .group) && (value.translation.width > 0) {
                        withAnimation {
                            selectedFilter = .personal
                        }
                    }
                    else if (selectedFilter == .personal) && (value.translation.width < 0) {
                        withAnimation {
                            selectedFilter = .group
                        }
                    }
                }
        )
        
    }
}

#Preview {
    NavigationStack{
        MainChatView()
    }
}
