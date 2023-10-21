//
//  CircleImage.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/17.
//

import SwiftUI
import Kingfisher

struct CircleImage: View {
    var body: some View {
        if let imageString = UserStore.shared.currentUser?.userImageURLString {
            KFImage(URL(string: imageString))
                .placeholder({
                    ProgressView()
                })
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100) // 100
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 7)
                }
                .padding(.leading, 20)
        } else {
            Image("chatUser")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100) // 100
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 7)
                }
                .padding(.leading, 20)
        }
    }
}

#Preview {
    CircleImage()
}
