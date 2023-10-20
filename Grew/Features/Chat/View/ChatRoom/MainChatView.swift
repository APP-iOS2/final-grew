//
//  UserContentListView.swift
//  ChatTestProject
//
//  Created by dayexx on 2023/09/25.
//

import SwiftUI

struct MainChatView: View {
    @State private var selectedFilter: ChatSegment = .group
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ChatSegment.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    
    var body: some View {
        VStack{
            segmentBar
            
            switch selectedFilter {
            case .group:
                ChatListView(filter: .group)
            case .personal:
                ChatListView(filter: .personal)
            }
            Spacer()
        }
    }
    
    private var segmentBar: some View {
        HStack{
            ForEach(ChatSegment.allCases) { filter in
                VStack(spacing: 8) {
                    Text(filter.title)
                        .font(selectedFilter == filter ? .b2_B : .b2_R)
                        .padding(.top, 8)
                    if selectedFilter == filter {
                        Rectangle()
                            .foregroundColor(.Main)
                            .frame(maxWidth: filterBarWidth, maxHeight: 1)
                            .matchedGeometryEffect(id: "item", in: animation)
                    } else {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: filterBarWidth, maxHeight: 1)
                    }
                }
                .contentShape(.rect)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(selectedFilter == filter ? Color.Main.opacity(0.1) : Color.Main.opacity(0.03))
                        .scaleEffect(selectedFilter == filter ? 1 : 0.8)
                )
                .onTapGesture {
                    withAnimation(.interactiveSpring()) {
                        selectedFilter = filter
                    }
                }
            }
        }
    }
}

