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
        //        UINavigationBar.appearance().backgroundColor = UIColor(Color.Main)
        let navBarAppearance = UINavigationBarAppearance()
        // 객체 생성
        //        navBarAppearance.backgroundColor = UIColor(Color.Main)
        navBarAppearance.shadowColor = .clear
        // 객체 속성 변경
        // 첫 화면으로 가만히 있을 때 - 없으면 스크롤 하게되면 사라짐
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        // 생성한 객체를 각각의 appearance에 할당
        
    }
    
    var body: some View {
        ScrollView {
            VStack {
                // 최신 일정
                NewestScheduleListView()
                
                // 카테고리 버튼
                CategoryButtonView()
                    .padding(.horizontal, 5)
                    .padding(.top)
                    .background(.white)
                    .cornerRadius(20, corners: [.topRight, .topLeft])
            }
            .background(Color.Main)
            
            
            VStack(alignment: .leading) {
                
                Divider()
                    .frame(height: 8)
                    .overlay(Color.BackgroundGray)
                    .padding(.vertical)
                Text("최신 그루")
                    .font(.b1_B)
                    .padding(.leading, 16)
                    .padding(.bottom)
                NewestGrewListView(grewList: grewViewModel.newestFilter(grewList: grewViewModel.grewList))
                    .padding(.horizontal, 8)
                
                
                Divider()
                    .frame(height: 8)
                    .overlay(Color.BackgroundGray)
                    .padding(.vertical)
                    .background(.white)
                
                // 인기 모임
                Text("인기 그루")
                    .font(.b1_B)
                    .padding(.leading, 16)
                GrewListView(grewList: grewViewModel.popularFilter(grewList: grewViewModel.grewList))
                
                
                
                
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

#Preview {
    HomeView()
        .environmentObject(GrewViewModel())
}
