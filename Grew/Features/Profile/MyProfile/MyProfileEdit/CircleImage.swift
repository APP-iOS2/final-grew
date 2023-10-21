//
//  CircleImage.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/17.
//

import SwiftUI

struct CircleImage: View {
    
    var body: some View {
        AsyncImage(url: URL(string: UserStore.shared.currentUser?.userImageURLString ?? "chatUser"), content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150) // 100
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 7)
                }
        }, placeholder: {
            ProgressView()
        })
        //            .shadow(radius: )
    }
}

#Preview {
    CircleImage()
}
