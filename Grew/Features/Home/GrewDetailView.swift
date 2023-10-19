//
//  GrewDetailView.swift
//  Grew
//
//  Created by 김효석 on 10/13/23.
//

import SwiftUI

enum GrewDetailFilter: Int, CaseIterable, Identifiable {
    
    case introduction
    case schedule
    case groot
    
    var title: String {
        switch self {
        case .introduction: return "소개"
        case .schedule: return "일정"
        case .groot: return "그루트"
        }
    }
    
    var id: Int { return self.rawValue }
}

struct GrewDetailView: View {
    @State private var selectedFilter: GrewDetailFilter = .introduction
    @Namespace private var animation
    
    private let headerHeight: CGFloat = 180
    
    var body: some View {
        VStack {
            ScrollView {
                makeHeaderImageView()
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        switch selectedFilter {
                        case .introduction:
                            GrewIntroductionView()
                        case .schedule:
                            ScheduleListView()
                        case .groot:
                            GrootListView()
                        }
                    } header: {
                        makeHeaderFilterView()
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    makeToolbarButtons()
                }
            }
            
            Divider()
                .padding(.bottom)
            
            makeBottomButtons()
        }
    }
    
}

// View 반환 함수
extension GrewDetailView {
    /// 헤더 이미지뷰
    private func makeHeaderImageView() -> some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1696757020926-d627b01c41cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=900&q=60")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: geometry.size.width,
                        height: headerHeight + geometry.frame(in: .global).minY > 0 ? headerHeight + geometry.frame(in: .global).minY : 0
                    )
                    .clipped()
                    .offset(y: -geometry.frame(in: .global).minY)
                
            } placeholder: {
                ProgressView()
            }
        }
        .frame(height: headerHeight)
    }
    
    /// segment 필터 뷰
    private func makeHeaderFilterView() -> some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(GrewDetailFilter.allCases, id: \.self) { segment in
                    VStack {
                        Text(segment.title)
                            .font(.b2_B)
                            .foregroundColor(selectedFilter == segment ? .Main : Color(uiColor: .black))
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 4)
                            if selectedFilter == segment {
                                Capsule()
                                    .fill(Color.Main)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "item", in: animation)
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5)) {
                            selectedFilter = segment
                        }
                    }
                }
            }
            .padding(.top)
            
            Rectangle()
                .frame(height: 8)
                .foregroundStyle(Color(hexCode: "ECECEC"))
        }
        .background(.white)
    }
    
    /// 툴바 버튼
    private func makeToolbarButtons() -> some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(.black)
            }
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.black)
            }
        }
    }
    
    /// 하단 하트, 참여하기 버튼
    private func makeBottomButtons() -> some View {
        HStack(spacing: 20) {
            Button {
                
            } label: {
                Image(systemName: "heart")
                    .resizable()
                    .foregroundStyle(.red)
            }
            .frame(width: 27, height: 24.19)
            
            Button {
                
            } label: {
                Text("참여하기")
            }
            .grewButtonModifier(width: 260, height: 44, buttonColor: .Main, font: .b1_B, fontColor: .white, cornerRadius: 8)
        }
        .padding(.horizontal)
    }
}



#Preview {
    NavigationStack {
        GrewDetailView()
    }
}
