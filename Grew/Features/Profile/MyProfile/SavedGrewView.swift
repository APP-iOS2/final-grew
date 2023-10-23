//
//  SavedGrewView.swift
//  Grew
//
//  Created by daye on 2023/10/21.
//

import SwiftUI

struct SavedGrewView: View {
    
    let grews: [Grew]
    
    var body: some View {
        if grews.isEmpty {
            ProfileGrewDataEmptyView(systemImage: "heart", message: "그루를 찜해보세요!", isSavedView: true)
        }else {
            VStack{
                Text("찜그루 있다.")
            }
        }
    }
}

/*
#Preview {
    NavigationStack {
        //SavedGrewView(grews:
    }
}
*/
