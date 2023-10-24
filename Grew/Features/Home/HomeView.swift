//
//  HomeView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var grewViewModel: GrewViewModel
    @EnvironmentObject var router: HomeRouter
    
    var body: some View {
        //        NavigationStack {
        ScrollView {
            VStack {
                // 최신 일정
                NewestScheduleListView()
                
                // 카테고리 버튼
                CategoryButtonView()
                    .padding(.horizontal, 5)
                    .padding(.top)
                    .background(.white)
                    .cornerRadius(44, corners: [.topRight, .topLeft])
                    .shadow(color: .black.opacity(0.15), radius: 4)
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
            .background(Color.white)
        } // ScrollView
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image("logo_white")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    //                        GrewSearchView()
                    //                            .navigationBarBackButtonHidden(true)
                    router.homeNavigate(to: .search)
                } label: {
                    Image("search")
                        .font(.title2)
                        .padding(.trailing, 5)
                    
                }
            }
        }
        .onAppear {
            grewViewModel.fetchGrew()
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
        .navigationBarBackground(.Main)
//        .toolbarBackground(
//            Color.Main,
//            for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
    }
    
}

#Preview {
    HomeView()
        .environmentObject(GrewViewModel())
}
