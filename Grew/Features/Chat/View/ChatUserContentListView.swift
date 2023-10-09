//
//  UserContentListView.swift
//  ChatTestProject
//
//  Created by dayexx on 2023/09/25.
//

import SwiftUI

struct ChatUserContentListView: View {
    var user: User?
    
    @State private var selectedFilter: ChatSegment = .group
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ChatSegment.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    
    var body: some View {
        // user content list view
        VStack {
            HStack{
                ForEach(ChatSegment.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(maxWidth: filterBarWidth, maxHeight: 2)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(maxWidth: filterBarWidth, maxHeight: 2)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            // 임시로 뷰 나눠뒀지만 필터링으로 개인이랑 그룹 나눠서 패치만 하면 될듯?
            switch selectedFilter {
            case .group:
                ChatListView()
            case .personal:
                ChatListView()
            }
            Spacer()
        }
        /* .gesture(
            DragGesture(minimumDistance: 2, coordinateSpace: .local)
                .onEnded { value in
                    if ((selectedFilter == .group) && (value.translation.width < 0)) {
                        withAnimation {
                            selectedFilter = .personal
                        }
                    }
                    else if ((selectedFilter == .personal) && (value.translation.width > 0)) {
                        withAnimation {
                            selectedFilter = .group
                        }
                    }
                }
        )*/
    }
}

#Preview {
    UserContentListView()
}
