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
            }
        }
//    } // NavigationStack
}

#Preview {
    HomeView()
        .environmentObject(GrewViewModel())
}
