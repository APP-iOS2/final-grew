//
//  ShowStumpsView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/19.
//

import SwiftUI

struct StumpCellView: View {
    
    let stump: Stump
    @State private var openHour: String = ""
    @State private var closedHour: String = ""
    
    var body: some View {
        HStack(spacing: 10) {
            if let imageURL = stump.imageURLs.first {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image("logo")
                }
                .frame(width: 130, height: 110)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            } else {
                Image("logo")
                    .frame(width: 130, height: 110)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
            }

            ZStack(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    Text(stump.name)
                        .font(.b1_B)
                        .padding(.bottom, 5)
                    Text(stump.location)
                        .font(.c1_R)
                        .padding(.bottom, 5)
                    Text("\(openHour) 에 영업 시작")
                        .font(.c1_R)
                        .padding(.bottom, 3)
                        .foregroundStyle(Color.DarkGray1)
                    Text("\(closedHour) 에 영업 종료")
                        .font(.c1_R)
                        .foregroundStyle(Color.DarkGray1)
                }
            }
        }
        .onAppear {
            let hours = stump.hours.components(separatedBy: "~")
            if let firstHour = hours.first {
                openHour = firstHour
            }
            if let secondHour = hours.last {
                closedHour = secondHour
            }
        }
    }
}

#Preview {
    StumpCellView(
        stump: Stump(
            id: "id",
            stumpMemberId: "stumpMemberId",
            name: "루트7 보드게임 카페",
            hours: "08:00~14:00",
            minimumMembers: "3",
            maximumMembers: "10",
            isNeedDeposit: true,
            deposit: "100,000",
            location: "서울특별시 노원구 공릉로 207 302호",
            phoneNumber: "010-0000-0000",
            imageURLs: [
                "https://mblogthumb-phinf.pstatic.net/MjAyMjEyMjdfMTk5/MDAxNjcyMTA4NDk0NDc2.juvA0mMh4p7iojZaNHZMp0UEY4t_Dz_jigVssiKFy7Ag.s7AIvVzSCjbuK4MvlnSEnwV9fQlfp6BLDmSXlLmoAbgg.JPEG.qmfosej/IMG_3994.jpg?type=w800",
                "",
                ""
            ]
        )
    )
}
