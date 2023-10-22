//
//  NewestGrewListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/18.
//

import SwiftUI

struct NewestGrewListView: View {
    
    let grewList: [Grew]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(grewList) { grew in
                    NavigationLink {
                        GrewDetailView(grew: grew)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        NewestGrewCellView(grew: grew)
                            .padding(.horizontal, 8)
                    }
                }
            } //: LazyHStack
        } //: ScrollView
    }
}

#Preview {
    NewestGrewListView(grewList: [])
}
