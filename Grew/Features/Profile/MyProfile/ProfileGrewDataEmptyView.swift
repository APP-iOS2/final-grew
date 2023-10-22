//
//  ProfileGrewDataEmptyView.swift
//  Grew
//
//  Created by daye on 10/22/23.
//
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
