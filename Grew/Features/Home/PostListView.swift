//
//  PostListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/05.
//

import SwiftUI

struct PostListView: View {
    
    let grewList: [TempGrew]
    
    
    var body: some View {
        VStack {
            ForEach(grewList) { grew in
                NavigationLink{
                    Text("\(grew.title) 게시글")
                } label: {
                    PostCellView(grew: grew)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    PostListView(grewList: [])
}
