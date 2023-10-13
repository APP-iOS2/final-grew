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
    private let headerHeight: CGFloat = 262
    private let id = "a"
    
    @State private var selected: GrewDetailFilter = .introduction
    @Namespace var animation
    
    var body: some View {
        VStack {
            ScrollView {
                GeometryReader { geometry in
                    AsyncImage(url: URL(string: "https://m.picturemall.co.kr/web/product/big/202102/13d2dbec19d4f232833724454bb58671.jpg")) { image in
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
                .padding(.bottom)
                
                VStack {
                    HStack(spacing: 0) {
                        ForEach(GrewDetailFilter.allCases, id: \.self) { segment in
                            VStack {
                                Text(segment.title)
                                    .font(.b2_B)
                                    .foregroundColor(selected == segment ? .Main : Color(uiColor: .black))
                                ZStack {
                                    Capsule()
                                        .fill(Color.clear)
                                        .frame(height: 4)
                                    if selected == segment {
                                        Capsule()
                                            .fill(Color.Main)
                                            .frame(height: 4)
                                            .matchedGeometryEffect(id: "item", in: animation)
                                    }
                                }
                            }
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.5)) {
                                    selected = segment
                                }
                            }
                        }
                    }
                }
                
                Rectangle()
                    .frame(height: 8)
                    .foregroundStyle(Color(hexCode: "ECECEC"))
                
                switch selected {
                case .introduction:
                    GrewIntroductionView()

                case .schedule:
                    Text("일정")
                case .groot:
                    Text("그루트")
                }
                
                
            }
            .edgesIgnoringSafeArea(.all)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
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
            }
            
            Divider()
                .padding(.bottom)
            
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
                .grewButtonModifier(width: 260, height: 44, buttonColor: .Main, font: .b1_B)
            }
            .padding(.horizontal)
        }
    }
    

}



#Preview {
    NavigationStack {
        GrewDetailView()
    }
}
