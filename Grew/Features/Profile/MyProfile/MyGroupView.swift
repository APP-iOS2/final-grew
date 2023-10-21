//
//  MyGroup.swift
//  Grew
//
//  Created by daye on 2023/10/21.
//

import SwiftUI

struct MyGroupView: View {
    
    var body: some View {
        VStack{
            ForEach(0..<10){ i in
                GrewListItemView()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
            }
        }.padding(.bottom, 30)
    }
}

#Preview {
    NavigationStack {
        MyGroupView()
    }
}
