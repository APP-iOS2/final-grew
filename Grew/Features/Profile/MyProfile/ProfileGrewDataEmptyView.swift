//
//  ProfileGrewDataEmptyView.swift
//  Grew
//
//  Created by daye on 10/22/23.
//
<<<<<<< HEAD

=======
>>>>>>> 0204374 (Feat: 채팅버블 및 스케쥴생성뷰 수정, ProfileEmptyDataView 추가, Profile 뷰모델 생성)
import SwiftUI

struct ProfileGrewDataEmptyView: View {
    var systemImage: String
    var message: String
    var isSavedView: Bool?
    var body: some View {
        VStack{
            Image(systemName: systemImage)
                .font(.system(size: 30))
                .foregroundColor(isSavedView ?? false ? .pink : .black)
                .padding()
            Text(message)
                .font(.b1_R)
        }.frame(height: UIScreen.main.bounds.height/3)
    }
}

#Preview {
    ProfileGrewDataEmptyView(systemImage: "heart", message: "그루를 찜해보세요!")
}
