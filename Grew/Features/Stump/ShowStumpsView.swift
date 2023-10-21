//
//  ShowStumpsView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/19.
//

import SwiftUI

struct ShowStumpsView: View {
    
    @EnvironmentObject var stumpStore: StumpStore
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://mblogthumb-phinf.pstatic.net/MjAyMjEyMjdfMTk5/MDAxNjcyMTA4NDk0NDc2.juvA0mMh4p7iojZaNHZMp0UEY4t_Dz_jigVssiKFy7Ag.s7AIvVzSCjbuK4MvlnSEnwV9fQlfp6BLDmSXlLmoAbgg.JPEG.qmfosej/IMG_3994.jpg?type=w800")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 130, height: 110)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            ).padding(.leading, 15)
            ZStack(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    Text("루트7 보드게임 카페")
                        .font(.b1_B)
                        .padding(.bottom, 5)
                    Text("서울특별시 노원구 공릉로 207 302호")
                        .font(.c1_R)
                        .padding(.bottom, 5)
                    Text("08:00 에 영업 시작")
                        .font(.c1_R)
                        .padding(.bottom, 3)
                        .foregroundStyle(Color.DarkGray1)
                    Text("18:00 에 영업 종료")
                        .font(.c1_R)
                        .foregroundStyle(Color.DarkGray1)
                }
                .padding(.trailing, 30)
                .padding(.leading, 10)
            }
        }
        
        
//        List {
//            ForEach(stumpStore.stumps) { stump in
//                Text("stump.name")
//            }
//        }
//        .onAppear {
//            Task {
//                await stumpStore.fetchStumps()
//            }
//        }
    }
}

#Preview {
    ShowStumpsView()
        .environmentObject(StumpStore())
}
