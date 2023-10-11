//
//  PostImageView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import Kingfisher
import SwiftUI


struct GrewImageView: View {
    let image: String
    var body: some View {
        KFImage(URL(string: image))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 110, height: 110)
            .cornerRadius(12)
    }
}

#Preview {
    GrewImageView(image: "")
}
