//
//  NewestGrewListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/18.
//

import SwiftUI

struct NewestGrewListView: View {
    
    @EnvironmentObject var router: Router
    
    let grewList: [Grew]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(grewList) { grew in
                    Button {
//                        GrewDetailView(grew: grew)
                        router.navigate(to: .grewDetail(grew: grew))
                    } label: {
                        NewestGrewCell(grew: grew)
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
