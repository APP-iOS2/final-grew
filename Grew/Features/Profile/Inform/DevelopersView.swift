//
//  DevelopersView.swift
//  Grew
//
//  Created by Chloe Chung on 2023/10/18.
//

import SwiftUI

struct DevelopersView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            InformWebKit(url: "https://github.com/APPSCHOOL3-iOS/final-grew")
        }
        .navigationTitle("개발자 정보")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
        }))
    }
}

#Preview {
    DevelopersView()
}
