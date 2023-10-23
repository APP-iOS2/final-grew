//
//  MyGroup.swift
//  Grew
//
//  Created by daye on 2023/10/21.
//

import SwiftUI

struct MyGroupView: View {

    let user: User?
    let grews: [Grew]
    
    var body: some View {
        if grews.isEmpty{
            ProfileGrewDataEmptyView(systemImage: "person.2", message: "아직 그루가 없어요.")
        }else{
            VStack {
                ForEach(grews){ grew in
                    NavigationLink{
                        GrewDetailView(grew: grew)
                    }label: {
                        GrewCellView(grew: grew)
                            .padding(.trailing, 5)

                            .foregroundColor(.black)
                    }
                }
            }.padding(.top, 5)
            .padding(.bottom, 30)
        }
    }
}

/*
#Preview {
    NavigationStack {
        MyGroupView(user: User.dummyUser, profile: )
    }
}*/
