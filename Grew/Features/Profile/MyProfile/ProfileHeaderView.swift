//
//  ProfileHeaderView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/10.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ProfileHeaderView: View {
    @State var name: String
    @State var statusMessage: String
    
    private var backgroundHeight: CGFloat {
        //        let count = CGFloat(ProfileThreadFilter.allCases.count)
        //        return UIScreen.main.bounds.height / count - 100
        return UIScreen.main.bounds.height / 5
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    ZStack(alignment: .leading) {
                        RoundSpecificCorners()
                            .offset(x: 0, y: 60.0)
                        
                        HStack(alignment: .bottom) {
                            CircleImage()
                            
                            Spacer()
                            
                            NavigationLink {
                                EditProfileView(name: UserStore.shared.currentUser?.nickName ?? "",
                                                statusMessage: UserStore.shared.currentUser?.introduce ?? "")
                            } label: {
                                Text("프로필 수정")
                                    .background(RoundedRectangle(cornerRadius: 7)
                                        .foregroundColor(.LightGray2)
                                        .frame(width: 101, height: 32)
                                        .font(.c1_B))
                            }
                            .foregroundColor(.white)
                            .padding()
                        }
                        .padding()
                    }
                    
                    Text(UserStore.shared.currentUser?.nickName ?? "이름없음")
                        .padding(.horizontal)
                        .bold()
                    
                    Text(UserStore.shared.currentUser?.introduce ?? "안녕하세요 \(UserStore.shared.currentUser?.nickName ?? "이름없음")입니다.")
                        .padding(.horizontal)
                        .font(.caption)
                    
                    Divider()
                    
                }
            }
            .background(Color.grewMainColor)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileHeaderView(name: "헬롱", statusMessage: "하위")
    }
}
