//
//  GrootView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct GrootView: View {
    
    let memberId: String
    
    @State private var member: User?
    @Binding var selection: SelectViews
    
    var body: some View {
        HStack {
            NavigationLink {
                ProfileView(selection: $selection, user: member)
            } label: {
                AsyncImage(url: URL(string: member?.userImageURLString ?? "")) { image in
                    image
                        .rounded(width: 44, height: 44)
                        .padding(.trailing, 1)
                } placeholder: {
                    Image(.defaultProfile)
                        .rounded(width: 44, height: 44)
                        .padding(.trailing, 1)
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("\(member?.nickName ?? "이름 없음")")
                        .font(.b3_B)
                        .padding([.trailing, .bottom], 1)
                    Text("")
                        .font(.c2_B)
                        .foregroundStyle(Color.Sub)
                }
                Text("\(member?.introduce ?? "자기소개를 작성해주세요.")")
                    .font(.c1_L)
            }
            Spacer()
        }
        .onAppear(perform: {
            Task {
                member = try await UserStore.shared.findUser(id: memberId)
            }
        })
    }
}

#Preview {
    GrootView(memberId: "ID", selection: .constant(.profile))
        .environmentObject(UserViewModel())
}
