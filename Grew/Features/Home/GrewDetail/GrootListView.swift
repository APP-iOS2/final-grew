//
//  GrootListView.swift
//  Grew
//
//  Created by KangHo Kim on 2023/10/18.
//

import SwiftUI

struct GrootListView: View {
    var body: some View {
        LazyVStack(spacing: 16, content: {
            ForEach(1...10, id: \.self) { _ in
                GrootView()
            }
        })
        .padding(20)
    }
}

#Preview {
    GrootListView()
}
