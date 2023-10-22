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
    
    let user: User
    
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
                
                CircleImage()
                
                HStack(alignment: .bottom){
                    
                    VStack(alignment: .leading){
                        Text(user.nickName)
                            .font(.b1_R)
                        Text(user.introduce ?? "안녕하세요 \(user.nickName)입니다.")
                            .font(.b3_L)
                            .padding(.vertical, 5)
                    }
                    Spacer()
                    
                    NavigationLink {
                        EditProfileView(
                            user: user
                        )
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
            .frame(height: UIScreen.main.bounds.height / 3)
    }
    
}

#Preview {
    NavigationStack {
        ProfileHeaderView(user: UserStore.shared.currentUser!)
    }
}
