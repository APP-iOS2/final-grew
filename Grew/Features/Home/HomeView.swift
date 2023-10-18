//
//  HomeView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var grewViewModel: GrewViewModel
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(Color.Main)
        let navBarAppearance = UINavigationBarAppearance()
        // 객체 생성
        navBarAppearance.backgroundColor = UIColor(Color.Main)
        navBarAppearance.shadowColor = .clear
        // 객체 속성 변경
        // 첫 화면으로 가만히 있을 때 - 없으면 스크롤 하게되면 사라짐
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        // 생성한 객체를 각각의 appearance에 할당
        
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    // 최신 일정
                    NewGrewListView()
                    
                    // 카테고리 버튼
                    CategoryButtonView()
                        .padding(.horizontal, 5)
                        .padding(.vertical)
                        .background(.white)
                        .cornerRadius(20, corners: [.topRight, .topLeft])
                }
                .background(Color.Main)
                
                
                // 신규, 인기, 일정 어떻게 나눠서 할지, Grew의 구조체 User구조체에 하트를 눌렀을 때 반응할 프로퍼티 필요함
                // 신규에 쓰일 Grew 생성 시간을 담을 프로퍼티 필요함
                // 목록마다 3개씩
                // 모임 일정에 대한 자세한 정의 필요
                
                // 신규모임, 인기모임
                
                VStack(alignment: .leading) {
                    //                    Divider()
                    //                        .frame(height: 8)
                    //                        .overlay(Color.BackgroundGray)
                    //                        .padding(.bottom, 16)
                    //
                    //                    Text("신규 모임")
                    //                        .font(.h1_B)
                    //                        .padding(.leading, 16)
                    //                    GrewListView(grewList: grewViewModel.grewList)
                    //
                    Divider()
                        .frame(height: 8)
                        .overlay(Color.BackgroundGray)
                        .padding(.vertical)
                        .background(.white)
                    
                    // 인기 모임 5개
                    Text("인기 그루")
                        .font(.h1_B)
                        .padding(.leading, 16)
                    GrewListView(grewList: grewViewModel.popularFilter(grewList: grewViewModel.grewList))
                    
                    //
                    //                    Divider()
                    //                        .frame(height: 8)
                    //                        .overlay(Color.BackgroundGray)
                    //                        .padding(.vertical)
                    
                    // 전체 모임 일정, 전체 모임
                    //                    Text("곧 시작하는 모임")
                    //                        .font(.h1_B)
                    //                        .padding(.leading, 16)
                    //                    GrewScheduleListView(grewList: grewViewModel.grewList)
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
        .environmentObject(GrewViewModel())
}
