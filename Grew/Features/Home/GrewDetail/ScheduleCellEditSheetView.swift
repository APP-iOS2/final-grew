//
//  ScheduleCellEditSheetView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/16.
//

import SwiftUI

struct ScheduleCellEditSheetView: View {
    var body: some View {
        VStack {
            HStack {
                Text("수정하기")
                Spacer()
                Image(systemName: "pencil")
            }
            .padding(.vertical, 8)
            Divider()
            HStack {
                Text("삭제하기")
                Spacer()
                Image(systemName: "trash")
            }
            .padding(.vertical, 8)
            .foregroundColor(.Error)
            Divider()
            HStack {
                Text("신고하기")
                Spacer()
                Image(systemName: "exclamationmark.bubble")
            }
            .padding(.vertical, 8)
            .foregroundColor(.Error)
        }
        .font(.b2_R)
        .padding(20)
    }
}

#Preview {
    ScheduleCellEditSheetView()
}
