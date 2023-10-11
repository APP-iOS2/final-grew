//
//  PostListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct GrewListView: View {
    
    let grewList: [Grew]
    
    
    var body: some View {
        VStack {
            ForEach(grewList) { grew in
                NavigationLink{
                    Text("\(grew.title) 게시글")
                } label: {
                    GrewCellView(grew: grew)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    GrewListView(grewList: [])
}
