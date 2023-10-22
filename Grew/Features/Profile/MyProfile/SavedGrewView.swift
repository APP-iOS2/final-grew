//
//  SavedGrewView.swift
//  Grew
//
//  Created by daye on 2023/10/21.
//

import SwiftUI

struct SavedGrewView: View {
    var body: some View {
        ProfileGrewDataEmptyView(systemImage: "heart", message: "그루를 찜해보세요!", isSavedView: true)
    }
}

#Preview {
    NavigationStack {
        SavedGrewView()
    }
}
