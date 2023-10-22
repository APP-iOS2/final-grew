//
//  GrootView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct GrootView: View {
    
    @EnvironmentObject private var userViewModel: UserViewModel
    let user: User?
    @Binding var selection: SelectViews
    
    var body: some View {
        HStack {
            NavigationLink {
                ProfileView(selection: $selection, user: userViewModel.currentUser)
            } label: {
                AsyncImage(url: URL(string: userViewModel.currentUser?.userImageURLString ?? "")) { image in
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
                    Text("\(userViewModel.currentUser?.nickName ?? "닉네임이 없다고..?")")
                        .font(.b3_B)
                        .padding([.trailing, .bottom], 1)
                    Text("")
                        .font(.c2_B)
                        .foregroundStyle(Color.Sub)
                }
                Text("\(userViewModel.currentUser?.introduce ?? "자기소개를 작성해주세요.")")
                    .font(.c1_L)
            }
            Spacer()
        }
        .onAppear(perform: {
            userViewModel.fetchUser(userId: UserStore.shared.currentUser?.id ?? "")
        })
    }
}

#Preview {
    GrootView(user: User.dummyUser, selection: .constant(.profile))
        .environmentObject(UserViewModel())
}
