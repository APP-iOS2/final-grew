//
//  ProfileCircleImageView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/13.
//

import SwiftUI

struct ProfileCircleImageView: View {
    var body: some View {
        Image("defaultProfile")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 48)
            .clipShape(Circle())
            .shadow(radius: 5)
            .overlay{
                Circle().stroke(.white, lineWidth: 4)
            }

    }
}

#Preview {
    ProfileCircleImageView()
}
