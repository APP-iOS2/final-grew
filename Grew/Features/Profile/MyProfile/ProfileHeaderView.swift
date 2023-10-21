//
//  ProfileHeaderView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/10.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct ProfileHeaderView: View {
    @State var name: String
    @State var statusMessage: String
    
    private var backgroundHeight: CGFloat {
        //        let count = CGFloat(ProfileThreadFilter.allCases.count)
        //        return UIScreen.main.bounds.height / count - 100
        return UIScreen.main.bounds.height / 5
    }
    
    var body: some View {
            ZStack(alignment: .bottom) {
                RoundSpecificCorners()

                VStack(alignment: .leading) {
                    Spacer()
                    // 이미지 안떠서 일단 뷰 패딩 안맞춰둠
                    CircleImage()
                        .padding(50)
                   
                    HStack(alignment: .bottom){
                        VStack(alignment: .leading){
                            Text(UserStore.shared.currentUser?.nickName ?? "이름없음")
                                .font(.b1_R)
                            Text(UserStore.shared.currentUser?.introduce ?? "안녕하세요 \(UserStore.shared.currentUser?.nickName ?? "이름없음")입니다.")
                                .font(.b3_L)
                                .padding(.vertical, 5)
                        }
                        Spacer()
                        
                        NavigationLink {
                            EditProfileView(name: UserStore.shared.currentUser?.nickName ?? "",
                                            statusMessage: UserStore.shared.currentUser?.introduce ?? "")
                        } label: {
                            Text("프로필 수정")
                                .font(.c1_B)
                                .background(RoundedRectangle(cornerRadius: 7)
                                    .foregroundColor(.LightGray2)
                                    .frame(width: 90, height: 28)
                                )
                        }
                        .padding(10)
                        .foregroundColor(.white)
                    }.padding(10)
                        .padding(.horizontal, 10)
                    
                    Divider()
                }
                   
            }.background(Color.grewMainColor)
            .frame(height: UIScreen.main.bounds.height/7*2)
        
     
    }
    
}

#Preview {
    NavigationStack {
        ProfileHeaderView(name: "헬롱", statusMessage: "하위")
    }
}
