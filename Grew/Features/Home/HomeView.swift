//
//  HomeView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var postViewModel = TempGrewViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // 배너
                
                // 카테고리 버튼
                CategoryButtonView(postViewModel: postViewModel)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
                    .background(.gray)
                
                // 신규, 인기, 일정 어떻게 나눠서 할지, Grew의 구조체 User구조체에 하트를 눌렀을 때 반응할 프로퍼티 필요함
                // 신규에 쓰일 Grew 생성 시간을 담을 프로퍼티 필요함
                
                // 신규모임, 인기모임
                PostListView(grewList: postViewModel.grewList)
                
                // 모임 일정, 전체 모임
                
                
            }
            .navigationTitle("Grew")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            postViewModel.fetchGrew()
        }
    }
}

#Preview {
    HomeView()
}
