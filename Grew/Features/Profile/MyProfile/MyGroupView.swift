//
//  MyGroup.swift
//  Grew
//
//  Created by daye on 2023/10/21.
//

import SwiftUI

struct MyGroupView: View {
    
    @EnvironmentObject var grewViewModel: GrewViewModel
    
    let user: User?
    let grews: [Grew]
    
    var body: some View {
        VStack {
            //ProfileGrewDataEmptyView(systemImage: "person.2", message: "아직 그루가 없어요.")
            ForEach(grews){ grew in
                GrewListItemView(grew: grew)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
            }
        }.padding(.bottom, 30)
    }
}

/*
#Preview {
    NavigationStack {
        MyGroupView(user: User.dummyUser)
    }
}*/
