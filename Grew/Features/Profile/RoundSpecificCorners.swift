//
//  RoundSpecificCorners.swift
//  Grew
//
//  Created by Chloe Chung on 2023/09/26.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundSpecificCorners: View {
    var body: some View {
        Rectangle()
            .font(.largeTitle)
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width, height: 110)
            .roundedCorner(20, corners: [.topLeft, .topRight])
            
    }
}

#Preview {
    RoundSpecificCorners()
}
