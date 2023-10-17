//
//  UserContentListView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/25.
//

import SwiftUI

struct UserContentListView: View {
    var user: Grew?
    
    @State private var selectedFilter: ProfileThreadFilter = .myGroup
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count /*- 30*/
    }
    
    private let headerHeight: CGFloat = 262
    
    var body: some View {
        // user content list view
        VStack {
            HStack{
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(Color.grewMainColor)
                                .frame(maxWidth: filterBarWidth, maxHeight: 5)
                                .cornerRadius(5)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(maxWidth: filterBarWidth, maxHeight: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5)) {
                            selectedFilter = filter
                        }
                    }
                }
            }
        }
        .frame(height: 50, alignment: .center)
        .background(Color.white)
        
        switch selectedFilter {
        case .myGroup:
            MyGroupView()
                .background(Color.white)
        case .myGroupSchedule:
            MyGroupScheduleView()
                .background(Color.white)
        case .savedGrew:
            SavedGrewView()
                .background(Color.white)
        }
    }
}


#Preview {
    UserContentListView()
}
