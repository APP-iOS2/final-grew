//
//  GrewScheduleImage.swift
//  Grew
//
//  Created by 정유진 on 2023/10/10.
//

import Kingfisher
import SwiftUI


struct GrewScheduleImage: View {
    let image: String
    var body: some View {
        KFImage(URL(string: image))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(12)
    }
}

#Preview {
    GrewScheduleImage(image: "")
}
