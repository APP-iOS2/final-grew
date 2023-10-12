//
//  HomeView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var grewViewModel = GrewViewModel()
    
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
                CategoryButtonView(grewViewModel: grewViewModel)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
                    .background(.gray)
                
                // 신규, 인기, 일정 어떻게 나눠서 할지, Grew의 구조체 User구조체에 하트를 눌렀을 때 반응할 프로퍼티 필요함
                // 신규에 쓰일 Grew 생성 시간을 담을 프로퍼티 필요함
                // 목록마다 3개씩
                // 모임 일정에 대한 자세한 정의 필요
                
                // 신규모임, 인기모임
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    Text("신규 모임")
                        .font(.h1_B)
                        .padding(.leading, 16)
                    GrewListView(grewList: grewViewModel.grewList)
                    
                    Divider()
                    
                    // 인기 모임
                    Text("인기 모임")
                        .font(.h1_B)
                        .padding(.leading, 16)
                    GrewListView(grewList: grewViewModel.grewList)
                    
                    Divider()
                    
                    // 전체 모임 일정, 전체 모임
                    Text("곧 시작하는 모임")
                        .font(.h1_B)
                        .padding(.leading, 16)
                    GrewScheduleListView(grewList: grewViewModel.grewList)
                }
            } // ScrollView
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("logo")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        Text("알림")
                    } label: {
                        Image("alert")
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        GrewSearchView()
                    } label: {
                        Image("search")
                            .font(.title2)
                            .padding(.trailing, 5)
                        
                    }
                }
            }
            
            .onAppear {
                grewViewModel.fetchGrew()
            }
        } // NavigationStack
    }
}

#Preview {
    HomeView()
}
