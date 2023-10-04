//
//  Image+Extensions.swift
//  ChattingModule
//
//  Created by cha_nyeong on 2023/09/26.
//

import Foundation
import SwiftUI

extension Image {
    //원형 뷰로 변경하기
    func rounded(width: CGFloat = 100, height: CGFloat = 100) -> some View {
        return self.resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
}
