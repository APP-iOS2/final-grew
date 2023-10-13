//
//  ScheduleCellView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/13.
//

import SwiftUI

struct ScheduleCellView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("# 1")
                    .padding()
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .frame(height: 40)
            .background(.green)
            ProfileCircleImageView()
                .offset(x: -38, y: -32)
                .padding(.bottom, -32)
            HStack {
                VStack(alignment: .leading) {
                    Text("날짜")
                    Text("인원")
                    Text("장소")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("2023-10-25")
                    Text("17/25")
                    Text("온라인")
                }
                .fontWeight(.bold)
            }
            .font(.caption)
            .padding(.top, 8)
            .padding(.horizontal)
        }
        .cornerRadius(6)
        .frame(width: 160, height: 160)
    }
}

#Preview {
    ScheduleCellView()
}
