//
//  SavedGrewView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/16.
//

import SwiftUI

struct SavedGrewView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Saved Grews")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SavedGrewView()
    }
}
