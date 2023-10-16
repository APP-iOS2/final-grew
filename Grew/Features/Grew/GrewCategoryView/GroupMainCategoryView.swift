//
//  GroupMainCategoryView.swift
//  Grew
//
//  Created by 윤진영 on 10/16/23.
//

import SwiftUI

struct GroupMainCategoryView: View {
    
    @EnvironmentObject var viewModel: GrewViewModel
    @State private var selection = Selection()
    
    
    var body: some View {
        ScrollView {
            GroupCategoryView(selection: $selection, showSubCategories: .constant(true))
            GroupSubCategoryView(selection: $selection)
        }
    }
}

#Preview {
    GroupMainCategoryView()
}
