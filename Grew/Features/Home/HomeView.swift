//
//  HomeView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var postViewModel = TempGrewViewModel()
    
    //    신규 모임 연산프로퍼티
    //    @State var newGrewList: [TempGrew] {
    //        get {
    //            return postViewModel.grewList.filter {
    //                $0 > $1
    //            }
    //        }
    //    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // 배너
                PagingBannerView()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(height: 200)
                    .padding(.horizontal, 5)
                
                // 카테고리 버튼
                CategoryButtonView(postViewModel: postViewModel)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
                    .background(.gray)
                
                // 신규, 인기, 일정 어떻게 나눠서 할지, Grew의 구조체 User구조체에 하트를 눌렀을 때 반응할 프로퍼티 필요함
                // 신규에 쓰일 Grew 생성 시간을 담을 프로퍼티 필요함
                // 목록마다 3개씩
                // 모임 일정에 대한 자세한 정의 필요
                
                // 신규모임, 인기모임
                Divider()
                VStack(alignment: .leading) {
                    Text("신규모임")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 16)
                    PostListView(grewList: postViewModel.grewList)
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("인기모임")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 16)
                    PostListView(grewList: postViewModel.grewList)
                }
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
