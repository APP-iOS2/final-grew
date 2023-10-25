//
//  NewestGrewListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/18.
//

import SwiftUI

struct NewestGrewListView: View {
    
    @EnvironmentObject var router: HomeRouter
    
    let grewList: [Grew]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(grewList) { grew in
                    Button {
                        router.homeNavigate(to: .grewDetail(grew: grew))
                    } label: {
                        NewestGrewCellView(grew: grew)
                            .padding(.horizontal, 8)
                    }
                }
            }
        }
    }
}

#Preview {
    NewestGrewListView(grewList: [])
}
