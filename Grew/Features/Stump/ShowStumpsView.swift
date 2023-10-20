//
//  ShowStumpsView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/19.
//

import SwiftUI

struct ShowStumpsView: View {
    
    @EnvironmentObject var stumpStore: StumpStore
    
    var body: some View {
        List {
            ForEach(stumpStore.stumps) { stump in
                Text(stump.name)
            }
        }
        .onAppear {
            Task {
                await stumpStore.fetchStumps()
            }
        }
    }
}

#Preview {
    ShowStumpsView()
}
