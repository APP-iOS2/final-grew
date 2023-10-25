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
        ScrollView {
            VStack {

                NewestScheduleListView()
                
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
                
                Text("인기 그루")
                    .font(.b1_B)
                    .padding(.leading, 16)
                GrewListView(grewList: grewViewModel.popularFilter(grewList: grewViewModel.grewList))
            }
            .background(Color.white)
        }
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image("logo_white")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
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
        .refreshable {
            grewViewModel.fetchGrew()
        }
        .navigationBarBackground(.Main)
    }
    
}

#Preview {
    HomeView()
        .environmentObject(GrewViewModel())
}
