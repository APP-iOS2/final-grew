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
                    .font(.b1_B)
                    .padding()
                    .foregroundColor(.white)
            }//: HStack
            .frame(height: 40)
            .background(Color.grewMainColor)
            ProfileCircleImageView()
                .offset(x: -38, y: -32)
                .padding(.bottom, -32)
            HStack {
                VStack(alignment: .leading) {
                    Text("날짜")
                        .padding(.vertical, 1)
                    Text("인원")
                        .padding(.vertical, 1)
                    Text("장소")
                        .padding(.vertical, 1)
                }//: VStack
                .font(.c1_R)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("2023-10-25")
                        .padding(.vertical, 1)
                    Text("17/25")
                        .padding(.vertical, 1)
                    Text("온라인")
                        .padding(.vertical, 1)
                }//: VStack
                .font(.c1_B)
            }//: HStack
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
        }//: VStack
        .background(Color.white)
        .cornerRadius(6)
        .frame(width: 160, height: 160)
        .shadow(radius: 3)
    }
}

#Preview {
    ScheduleCellView()
}
