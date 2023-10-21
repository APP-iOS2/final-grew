//
//  SavedGrewView.swift
//  Grew
//
//  Created by daye on 2023/10/21.
//

import SwiftUI

struct SavedGrewView: View {
    var body: some View {
        VStack{
            Image(systemName: "heart")
                .font(.system(size: 30))
                .foregroundColor(.pink)
                .padding()
            Text("그루를 찜해보세요!")
                .font(.b1_R)
        }.frame(height: UIScreen.main.bounds.height/3)
    }
}

#Preview {
    NavigationStack {
        SavedGrewView()
    }
}
