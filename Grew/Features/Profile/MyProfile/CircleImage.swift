//
//  CircleImage.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/17.
//

import SwiftUI

struct CircleImage: View {
    @State var userViewModel: UserViewModel
    
    var body: some View {
        Image(userViewModel.currentUser?.userImageURLString ?? "defaultProfile")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 115) // 100
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 7)
            }
//            .shadow(radius: )
    }
}

#Preview {
    CircleImage(userViewModel: UserViewModel())
}
